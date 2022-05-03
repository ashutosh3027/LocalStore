require("dotenv").config({ path: __dirname + "/config.env" });
const http = require("http");
const app = require("./app");
const { logger } = require("./utils/logger");

const server = http.createServer(app);

const PORT = process.env.PORT || 9000;

server.listen(PORT, () => logger.info(`Server running on port: ${PORT}`));
