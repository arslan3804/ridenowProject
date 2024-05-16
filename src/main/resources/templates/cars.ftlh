<!DOCTYPE html>
<html>
<head>
    <title>RideNow</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 20px;
        }
        .car-title {
            font-weight: bold;
        }
        .card {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">RideNow</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#catalog">Каталог авто</a>
                </li>
                <#if user.email??>
                    <li class="nav-item">
                        <a class="nav-link" href="/user/${user.id}">Личный кабинет</a>
                    </li>
                    <li class="nav-item">
                        <form action="/logout" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button type="submit" class="btn btn-link nav-link">Выйти</button>
                        </form>
                    </li>
                <#else>
                    <li class="nav-item">
                        <a class="nav-link" href="/login">Войти</a>
                    </li>
                </#if>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-3">
    <h1>RideNow</h1>
    <hr>

    <h4 class="mt-3">Поиск автомобиля по названию</h4>
    <form action="/" method="get" class="mb-3">
        <div class="input-group">
            <input type="text" class="form-control" name="title" placeholder="Поиск по названию объявления">
            <button type="submit" class="btn btn-primary">Поиск</button>
        </div>
    </form>

    <h2 id="catalog">Каталог авто</h2>
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-3">
        <#list cars as car>
            <div class="col">
                <div class="card">
                    <img src="/images/${car.previewImageId}" class="card-img-top" alt="Изображение авто">
                    <div class="card-body">
                        <p class="car-title">${car.title}</p>
                        <p>${car.price} руб. | <a href="/car/${car.id}" class="btn btn-primary">Подробнее...</a></p>
                    </div>
                </div>
            </div>
        </#list>
    </div>

    <#if user.isAdmin()>
        <h3 class="mt-3">Добавить новый товар</h3>
        <form action="/car/create" method="post" enctype="multipart/form-data" class="mb-3">
            <div class="mb-3">
                <input type="text" class="form-control" name="title" placeholder="Название объявления">
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" name="description" placeholder="Описание объявления">
            </div>
            <div class="mb-3">
                <input type="number" class="form-control" name="price" placeholder="Цена">
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" name="city" placeholder="Город">
            </div>
            <div class="mb-3">
                <input type="file" class="form-control" name="file1" accept="image/*">
            </div>
            <div class="mb-3">
                <input type="file" class="form-control" name="file2" accept="image/*">
            </div>
            <div class="mb-3">
                <input type="file" class="form-control" name="file3" accept="image/*">
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" class="btn btn-primary">Добавить товар</button>
        </form>
    </#if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
