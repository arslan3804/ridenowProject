<!DOCTYPE html>
<html>
<head>
    <title>RideNow</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h1 class="mt-5">RideNow</h1>
    <hr>

    <h4>Подробная информация о товаре</h4>
    <div class="row">
        <#list images as img>
            <div class="col-md-3 mb-3">
                <img src="/images/${img.id}" class="img-thumbnail" alt="Изображение товара">
            </div>
        </#list>
    </div>

    <div class="row">
        <div class="col-md-6">
            <b>Название товара:</b> ${car.title}<br>
            <b>Описание товара:</b> ${car.description}<br>
            <b>Цена:</b> ${car.price}<br>
            <b>Город:</b> ${car.city}<br>
        </div>
    </div>

    <form action="/car/rent" method="post" class="mt-3">
        <div class="mb-3">
            <label for="duration" class="form-label">Количество дней:</label>
            <input type="number" class="form-control" id="duration" name="duration">
        </div>
        <input type="hidden" name="carId" value="${car.id}">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn btn-primary">Взять в аренду</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
