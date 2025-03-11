
console.log("Hello, world");
const mongoose = require('mongoose');
const express = require("express");
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

const PORT = 3001;

const app = express();
const DB = "mongodb+srv://kritsimarsingh:aShKVLzmcnvRpOLR@cluster0.m0y0f.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"


app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

app.get("/test", (req,res)=> {
    res.json({
        message: "data received",
        name: "Mr. krit"
    });
})


mongoose.connect(DB).then(()=>{
    console.log('Connection Successful')
})
.catch((e)=> {
    console.log(e);
})

app.listen(PORT, () => {
    console.log(`connected at port ${PORT}`);
});