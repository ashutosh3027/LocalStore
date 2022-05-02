const jwt = require("jsonwebtoken");
const { ErrorHandler } = require("../helpers/error");

const verifyToken = (req, res, next) => {
  var token;
  if(req.headers["auth-token"])
  {token =req.headers["auth-token"].slice(1).slice(0, -1);}
  if (!token) {
    throw new ErrorHandler(401, "Token missing");
  }

  try {
    const verified = jwt.verify(token, process.env.SECRET);
    req.user = verified;
    next();
  } catch (error) {
    throw new ErrorHandler(401, error.message || "Invalid Token");
  }
};

module.exports = verifyToken;
