package com.example.ridenow.services;

import com.example.ridenow.models.Car;
import com.example.ridenow.models.Image;
import com.example.ridenow.models.User;
import com.example.ridenow.repositories.CarRepository;
import com.example.ridenow.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class CarService {
    private final CarRepository carRepository;
    private final UserRepository userRepository;
    private final EmailSenderService emailSenderService;

    public List<Car> listCars(String title) {
        if (title != null) return carRepository.findByTitle(title);
        return carRepository.findByUserIsNull();
    }

    public void saveCar(Car car, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {
        Image image1;
        Image image2;
        Image image3;
        if (file1.getSize() != 0) {
            image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            car.addImageToCar(image1);
        }
        if (file2.getSize() != 0) {
            image2 = toImageEntity(file2);
            car.addImageToCar(image2);
        }
        if (file3.getSize() != 0) {
            image3 = toImageEntity(file3);
            car.addImageToCar(image3);
        }
        log.info("Saving new Car. Title: {}; Author email: {}", car.getTitle());
        Car carFromDb = carRepository.save(car);
        carFromDb.setPreviewImageId(carFromDb.getImages().get(0).getId());
        carRepository.save(car);
    }

    public void rentCar(Principal principal, Car car, int duration) {
        User user = getUserByPrincipal(principal);

        Car rentedCar = new Car();
        rentedCar.setTitle(car.getTitle());
        rentedCar.setDescription(car.getDescription());
        rentedCar.setPrice(car.getPrice());
        rentedCar.setCity(car.getCity());
        rentedCar.setPreviewImageId(car.getPreviewImageId());
        rentedCar.setDateOfCreated(LocalDateTime.now());
        rentedCar.setDateOfRentEnd(car.getDateOfRentEnd());
        rentedCar.setDuration(duration);
        rentedCar.setUser(user);
        carRepository.save(rentedCar);

        int payment = rentedCar.getPrice() * duration;
        emailSenderService.sendSimpleEmail(user.getEmail(),
                "Аренда машины в таксопарке RideNow",
                String.format(
                        """ 
                        Здравствуйте, %s,
                        вы арендовали машину %s на %d дней за %d рублей в сутки.
                        Итого к оплате: %d рублей.
                        С уважением, таксопарк RideNow.
                        """,
                        user.getName(),
                        rentedCar.getTitle(),
                        rentedCar.getDuration(),
                        rentedCar.getPrice(),
                        payment));
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }

    public Car getCarById(Long id) {
        return carRepository.findById(id).orElse(null);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    public void flush() {
        carRepository.flush();
    }



}
