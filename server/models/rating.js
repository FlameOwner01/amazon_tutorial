const mongoose = require('mongoose');
const Product = require('./product');

const ratingSchema = mongoose.Schema({

    userId:{
        type: String,
        required: true,
    },
    rating: {
        type: Number,
        required: true,
    },




});

module.exports = ratingSchema;