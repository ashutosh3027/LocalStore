const { ErrorHandler } = require("../helpers/error");

module.exports = (req, res, next) => {
  const { roles } = req.user;
  console.log(roles);
  console.log(roles.includes("admin"));
  if (roles && roles.includes("admin")) {
    req.user = {
      ...req.user,
      roles,
    };
    return next();
  } else {
    throw new ErrorHandler(401, "require admin role");
  }
};
