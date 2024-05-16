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

    <h3>Подробная информация о пользователе ${user.name}</h3>
    <b>Email:</b> ${user.email}<br>

    <h4 class="mt-3">Взятые в аренду автомобили пользователя ${user.name}</h4>
    <div class="list-group">
        <#list cars as car>
            <a href="/car/${car.id}" class="list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">${car.title}</h5>
                    <small>${car.price} руб.</small>
                </div>
                <p class="mb-1">
                    <#if car.isRented()>
                        <span class="text-success">Аренда активна до ${car.getFormattedDateOfRentEnd()}</span>
                    <#else>
                        <span>Автомобиль свободен</span>
                    </#if>
                </p>


            </a>
        </#list>
    </div>

    <#if errorMessage??>
        <h2 class="mt-3" style="color: red">${errorMessage}</h2>
    </#if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
