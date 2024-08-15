import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { AccountRepository } from './accounts.repository';
import { LoggerService } from '../logger/logger.service';
import { AccountsMapper } from './accounts.mapper';
import { CreateAccountInput, UpdateAccountInput } from './dtos/account.dto';
import { randomUUID } from 'crypto';
import * as bcrypt from 'bcrypt';
import { AccountEntity } from './accounts.entity';

@Injectable()
export class AccountService {
  constructor(
    private readonly logger: LoggerService,
    private readonly repository: AccountRepository,
  ) {}

  async findAll() {
    try {
      this.logger.info({}, 'services > accounts > findAll > params');

      const output = await this.repository.findAll();

      this.logger.info({}, 'services > accounts > findAll > success');

      return {
        accounts: output,
      };
    } catch (error) {
      this.logger.error(error, 'services > accounts > findAll > exception');
      throw error;
    }
  }

  async findById(id: string) {
    try {
      this.logger.info({}, 'services > accounts > findById > params');

      const accountById = await this.repository.findById(id);

      this.logger.info(accountById, 'accountById');

      if (!accountById) {
        throw new NotFoundException('Accounts not found');
      }

      return AccountsMapper.toDto(accountById);
    } catch (error) {
      this.logger.error(error, 'services > accounts > findById > exception');
      throw error;
    }
  }

  async findByEmail(id: string) {
    try {
      this.logger.info({}, 'services > accounts > findByEmail > params');

      const accountByEmail = await this.repository.findByEmail(id);

      this.logger.info(accountByEmail, 'accountById');

      if (!accountByEmail) {
        throw new NotFoundException('Account not found');
      }

      return accountByEmail;
    } catch (error) {
      this.logger.error(error, 'services > accounts > findByEmail > exception');
      throw error;
    }
  }

  async create(input: CreateAccountInput) {
    try {
      this.logger.info(input, 'services > account > create > params');

      const emailExists = await this.repository.findByEmail(input.email);

      if (emailExists) {
        throw new ConflictException('Email already exists');
      }

      const id = randomUUID();
      const password = await bcrypt.hash(input.password, 10);
      const newAccount = new AccountEntity({
        ...input,
        id,
        password,
      });

      await this.repository.create(newAccount);

      this.logger.info({}, 'services > accounts > create > success');

      return newAccount;
    } catch (error) {
      this.logger.error(error, 'services > accounts > create > exception');
      throw error;
    }
  }

  async update(id: string, input: UpdateAccountInput) {
    try {
      this.logger.info(
        { id, ...input },
        'services > accounts > update > params',
      );

      const account = await this.repository.findById(id);

      this.logger.info(account, 'account');

      if (!account) {
        throw new NotFoundException('Account not found');
      }

      Object.assign(account, input);

      await this.repository.update(account);

      this.logger.info({}, 'services > accounts > update > success');
    } catch (error) {
      this.logger.error(error, 'services > accounts > update > exception');
      throw error;
    }
  }

  async delete(id: string) {
    try {
      this.logger.info({ id }, 'services > accounts > delete > params');

      await this.repository.delete(id);

      this.logger.info({}, 'services > accounts > delete > success');
    } catch (error) {
      this.logger.error(error, 'services > accounts > delete > exception');
      throw error;
    }
  }
}
