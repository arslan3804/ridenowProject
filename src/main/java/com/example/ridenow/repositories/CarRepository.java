package com.example.ridenow.repositories;

import com.example.ridenow.models.Car;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CarRepository extends JpaRepository<Car, Long> {
    List<Car> findByTitle(String title);
    List<Car> findByUserIsNull();
}
