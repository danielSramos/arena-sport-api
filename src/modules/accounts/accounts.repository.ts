import { Injectable } from '@nestjs/common';
import { AccountEntity, AccountProps } from './accounts.entity';
import { LoggerService } from '../logger/logger.service';
import { DatabaseService } from '../database/database.service';

@Injectable()
export class AccountRepository {
  constructor(
    private readonly logger: LoggerService,
    private readonly db: DatabaseService,
  ) {}

  async findAll() {
    try {
      const accounts = await this.db.users.findMany();

      return accounts.map(
        (account) => new AccountEntity(account as unknown as AccountProps),
      );
    } catch (error) {
      this.logger.error(error, 'AccountRepository > list > exception');
      throw error;
    }
  }

  async findByEmail(email: string) {
    try {
      const accountByEmail = await this.db.users.findUnique({
        where: { email },
      });

      if (!email) {
        return undefined;
      }

      return accountByEmail;
    } catch (error) {
      this.logger.error(error, 'AccountRepository > findByEmail > exception');
      throw error;
    }
  }

  async findById(id: string) {
    try {
      const accountById = await this.db.users.findUnique({
        where: {
          id,
        },
      });

      if (!accountById) {
        return undefined;
      }

      return new AccountEntity(accountById as unknown as AccountProps);
    } catch (error) {
      this.logger.error(error, 'AccountRepository > findById > exception');
      throw error;
    }
  }

  async create(entity: AccountEntity) {
    try {
      await this.db.users.create({
        data: entity.toJson(),
      });
    } catch (error) {
      this.logger.error(error, 'AccountRepository > create > exception');
      throw error;
    }
  }

  async update(entity: AccountEntity) {
    try {
      await this.db.users.update({
        data: entity.toJson(),
        where: {
          id: entity.id,
        },
      });
    } catch (error) {
      this.logger.error(error, 'AccountRepository > update > exception');
      throw error;
    }
  }

  async delete(id: string) {
    try {
      await this.db.users.delete({
        where: {
          id,
        },
      });
    } catch (error) {
      this.logger.error(error, 'AccountRepository > delete > exception');
      throw error;
    }
  }
}
