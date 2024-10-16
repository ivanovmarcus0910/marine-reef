<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>2D Aquatic</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            header {
                background-color: #000;
                color: #fff;
                padding: 10px 0;
            }
            header .container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }
            header .logo img {
                height: 50px;
            }
            header nav ul {
                list-style: none;
                display: flex;
                gap: 20px;
            }
            header nav ul li {
                display: inline;
            }
            header nav ul li a {
                color: #fff;
                text-decoration: none;
                font-weight: 700;
            }
            header .contact-info {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            header .contact-info i {
                color: #ffcc00;
            }
            .hero {
                position: relative;
                background: url('https://placehold.co/1920x600') no-repeat center center/cover;
                height: 600px;
                color: #fff;
                text-align: center;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            .hero h1 {
                font-size: 3rem;
                margin: 0;
            }
            .hero ul {
                list-style: none;
                padding: 0;
            }
            .hero ul li {
                margin: 10px 0;
            }
            .hero .btn {
                background-color: #ffcc00;
                color: #000;
                padding: 10px 20px;
                text-decoration: none;
                font-weight: 700;
                margin-top: 20px;
            }
            .section {
                padding: 40px 20px;
                max-width: 1200px;
                margin: 0 auto;
            }
            .section h2 {
                text-align: center;
                margin-bottom: 40px;
            }
            .products, .recommended, .services, .knowledge-share {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                justify-content: center;
            }
            .product, .recommended-item, .service, .knowledge-item {
                background-color: #fff;
                border: 1px solid #ddd;
                padding: 20px;
                text-align: center;
                flex: 1 1 calc(25% - 40px);
                box-sizing: border-box;
            }
            .product img, .recommended-item img, .knowledge-item img {
                max-width: 100%;
                height: auto;
            }
            .product h3, .recommended-item h3, .service h3, .knowledge-item h3 {
                font-size: 1.2rem;
                margin: 10px 0;
            }
            .product p, .recommended-item p, .service p, .knowledge-item p {
                font-size: 1rem;
                color: #666;
            }
            .footer {
                background-color: #f8f8f8;
                padding: 40px 20px;
                text-align: center;
            }
            .footer .container {
                max-width: 1200px;
                margin: 0 auto;
            }
            .footer .logo img {
                height: 100px;
            }
            .footer .links, .footer .contact, .footer .social {
                margin: 20px 0;
            }
            .footer .links ul, .footer .contact ul, .footer .social ul {
                list-style: none;
                padding: 0;
            }
            .footer .links ul li, .footer .contact ul li, .footer .social ul li {
                margin: 10px 0;
            }
            .footer .links ul li a, .footer .contact ul li a, .footer .social ul li a {
                color: #000;
                text-decoration: none;
            }
            .footer .social ul li a i {
                font-size: 1.5rem;
            }
            .footer .copyright {
                margin-top: 20px;
                font-size: 0.9rem;
                color: #666;
            }    </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="hero.jsp"/>
        <jsp:include page="products.jsp"/>
        <jsp:include page="services.jsp"/>
        <jsp:include page="knowledge.jsp"/>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
