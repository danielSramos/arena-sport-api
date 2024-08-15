import { Body, Controller, Get, Post } from '@nestjs/common';
import { LoggerService } from '../logger/logger.service';
import { AccountService } from './accounts.service';
import { get } from 'http';
import { CreateAccountInput } from './dtos/account.dto';

@Controller('accounts')
export class AccountController {
  constructor(
    private readonly logger: LoggerService,
    private readonly service: AccountService,
  ) {}

  @Get()
  findAll() {
    this.logger.info({}, 'controller > accounts > findAll');
    return this.service.findAll();
  }

  @Post()
  async create(@Body() body: CreateAccountInput) {
    this.logger.info({}, 'controller > accounts > create');

    await this.service.create(body);

    this.logger.info({}, 'controller > accounts > create > sucess');
  }
}
