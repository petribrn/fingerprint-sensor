import express from 'express';
import helmet from 'helmet';
import cors from 'cors';
import corsOptionsDelegate from './config/corsConfig';
import homeRoutes from './routes/homeRoutes';
import userRoutes from './routes/userRoutes';
import arduinoRoutes from './routes/arduinoRoutes';
import './database';

class App {
  constructor() {
    this.app = express();
    this.middlewares();
    this.routes();
  }

  middlewares() {
    this.app.use(express.urlencoded({ extended: true }));
    this.app.use(express.json());
    this.app.use(cors(corsOptionsDelegate));
    this.app.use(helmet());
  }

  routes() {
    this.app.use('/', homeRoutes);
    this.app.use('/users/', userRoutes);
    this.app.use('/arduino/', arduinoRoutes);
  }
}

export default new App().app;
