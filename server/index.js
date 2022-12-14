//IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin.js");


// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth.js");
const productRouter = require("./routes/product.js");
const userRouter = require("./routes/user.js");


//INIT
const PORT = 3000;
const app = express();

const DB = "mongodb+srv://Kerim:Kerim123kerim123@cluster0.0rchcef.mongodb.net/?retryWrites=true&w=majority";

//MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//CONNECTIONS

mongoose.connect(DB).then(() => {
  console.log("connection sueccesful");
})
.catch((e) =>{
  console.log(e)
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at ${PORT}`);
  });