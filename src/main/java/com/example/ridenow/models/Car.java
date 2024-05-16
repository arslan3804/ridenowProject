package com.example.ridenow.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "cars")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Car {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;
    @Column(name = "title")
    private String title;
    @Column(name = "description", columnDefinition = "text")
    private String description;
    @Column(name = "price")
    private int price;
    @Column(name = "city")
    private String city;
    @Column(name = "previewImageId")
    private Long previewImageId;
    @Column(name = "dateOfCreated")
    private LocalDateTime dateOfCreated;
    @Column(name = "duration")
    private int duration;
    @Column(name = "rentEndDate")
    private LocalDateTime dateOfRentEnd;

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn
    private User user;
    @PrePersist
    private void init() {
        dateOfCreated = LocalDateTime.now();
        dateOfRentEnd = dateOfCreated.plusDays(duration);
    }

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "car")
    private List<Image> images = new ArrayList<>();

    public void addImageToCar(Image image) {
        image.setCar(this);
        images.add(image);
    }
    public boolean isRented() {
        if (dateOfCreated == null || dateOfRentEnd == null) {
            return false;
        }
        LocalDateTime currentDate = LocalDateTime.now();
        return currentDate.isAfter(dateOfCreated) && currentDate.isBefore(dateOfRentEnd);
    }

    public String getFormattedDateOfRentEnd(){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return dateOfRentEnd.format(formatter);
    }


}
