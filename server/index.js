require("dotenv").config();
const express = require('express');
const mongoose = require('mongoose');
const router = require('./app/routes/user.route');
const path = require('path');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const connectDB = require('./config/database');

// require('dotenv').config();

let app = express();

app.use((req, res, next) => {
  res.setHeader("Content-Security-Policy", 
    "default-src 'self'; " +
    "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdn.jsdelivr.net; " +
    "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; " +
    "font-src 'self' https://fonts.gstatic.com https://eerieverse2.vercel.app; " +
    "img-src 'self' data:; " +
    "connect-src 'self' https://eerieverse2.vercel.app; " +
    "object-src 'none';"
  );
  next();
});


app.use(cookieParser());
app.use(express.urlencoded({extended:true}));
app.use(express.json());
app.use(cors());
app.use(express.static(path.join(__dirname, 'public')));



app.set('views', path.join(__dirname, 'app', 'views'));
app.set('view engine', 'ejs');



  


//import routes
app.use(router);




//http://localhost:8000/api/user/register
//http://localhost:8000/api/user/login



// Connect to MongoDB and start server
const startServer = async () => {
    try {
        await connectDB();
        const port = process.env.PORT || 8000;
        app.listen(port, () => {
            console.log(`Server is running on port ${port}`);
        });
    } catch (error) {
        console.error('Failed to start server:', error);
        process.exit(1);
    }
};

startServer();