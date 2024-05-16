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

    <h4 class="mt-3">Авторизация</h4>
    <form action="/login" method="post" class="mt-3">
        <div class="mb-3">
            <label for="email" class="form-label">Эл. почта:</label>
            <input type="email" class="form-control" id="email" name="username">
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Пароль:</label>
            <input type="password" class="form-control" id="password" name="password">
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn btn-primary">Вход</button>
    </form>

    <a href="/registration" class="mt-3">Зарегистрироваться</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
