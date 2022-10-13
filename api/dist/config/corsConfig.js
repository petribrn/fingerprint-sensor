"use strict";Object.defineProperty(exports, "__esModule", {value: true}); function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }var _dotenv = require('dotenv'); var _dotenv2 = _interopRequireDefault(_dotenv);

_dotenv2.default.config();

const corsWhiteList = [
  process.env.PROD_DOMAIN,
  process.env.DEV_DOMAIN,
];

const corsOptionsDelegate = (req, callback) => {
  let corsOptions;
  if (!req.header('Origin') || corsWhiteList.indexOf(req.header('Origin')) !== -1) {
    corsOptions = { origin: true };
  } else {
    corsOptions = { origin: false };
  }
  callback(null, corsOptions);
};

exports. default = corsOptionsDelegate;
