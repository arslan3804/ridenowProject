package com.example.ridenow.controllers;

import com.example.ridenow.models.Car;
import com.example.ridenow.models.User;
import com.example.ridenow.services.CarService;
import com.example.ridenow.services.EmailSenderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDateTime;

@Controller
@RequiredArgsConstructor
public class CarController {
    private final CarService carService;

    @GetMapping("/")
    public String cars(@RequestParam(name = "title", required = false) String title, Principal principal, Model model) {
        model.addAttribute("cars", carService.listCars(title));
        model.addAttribute("user", carService.getUserByPrincipal(principal));
        return "cars";
    }

    @GetMapping("/car/{id}")
    public String carInfo(@PathVariable Long id, Model model) {
        Car car = carService.getCarById(id);
        model.addAttribute("car", car);
        model.addAttribute("images", car.getImages());
        return "car-info";
    }

    @PostMapping("/car/rent")
    public String rentCar(Principal principal, @RequestParam Long carId, @RequestParam int duration) {
        Car car = carService.getCarById(carId);
        carService.rentCar(principal, car, duration);
        return "redirect:/";
    }

    @PostMapping("/car/create")
    public String createCar(@RequestParam("file1") MultipartFile file1,
                            @RequestParam("file2") MultipartFile file2,
                            @RequestParam("file3") MultipartFile file3,
                            Car car) throws IOException {
        carService.saveCar(car, file1, file2, file3);
        return "redirect:/";
    }
}
