import dotenv from 'dotenv';

dotenv.config();

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

export default corsOptionsDelegate;
