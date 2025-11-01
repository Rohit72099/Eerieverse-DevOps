const mongoose = require('mongoose');
require('dotenv').config();

const connectDB = async () => {
    try {
        // Remove deprecated options
        const connectionParams = {
            serverSelectionTimeoutMS: 5000, // Timeout after 5 seconds
            socketTimeoutMS: 45000, // Close sockets after 45 seconds of inactivity
        };

        console.log('Attempting to connect to MongoDB...');
        console.log('Connection string:', process.env.DBURL);

        const conn = await mongoose.connect(process.env.DBURL, connectionParams);
        
        console.log(`MongoDB Connected: ${conn.connection.host}`);
        
        // Handle connection events
        mongoose.connection.on('error', (err) => {
            console.error('MongoDB connection error:', err);
        });

        mongoose.connection.on('disconnected', () => {
            console.log('MongoDB disconnected');
        });

        mongoose.connection.on('connected', () => {
            console.log('MongoDB connected');
        });

    } catch (error) {
        console.error('MongoDB Connection Error:', error.message);
        console.error('Full error:', error);
        process.exit(1);
    }
};

module.exports = connectDB;