import { Sequelize } from 'sequelize';
import databaseConfig from '../config/database';
import User from '../models/User';

const models = [User];
const dbConnection = new Sequelize(databaseConfig);

models.forEach((model) => model.init(dbConnection));
models.forEach((model) => model.associate && model.associate(dbConnection.models));
