/*
  Warnings:

  - You are about to drop the `courts_schedule` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `event` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `permission` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `phone_number` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `profile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `schedule` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user_phone_number` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user_profile` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `courts` DROP FOREIGN KEY `courts_scheduleId_fkey`;

-- DropForeignKey
ALTER TABLE `courts_schedule` DROP FOREIGN KEY `courts_schedule_courtsId_fkey`;

-- DropForeignKey
ALTER TABLE `courts_schedule` DROP FOREIGN KEY `courts_schedule_scheduleId_fkey`;

-- DropForeignKey
ALTER TABLE `event_status` DROP FOREIGN KEY `event_status_eventId_fkey`;

-- DropForeignKey
ALTER TABLE `profile_permission` DROP FOREIGN KEY `profile_permission_permissionId_fkey`;

-- DropForeignKey
ALTER TABLE `profile_permission` DROP FOREIGN KEY `profile_permission_profileId_fkey`;

-- DropForeignKey
ALTER TABLE `user_phone_number` DROP FOREIGN KEY `user_phone_number_phoneNumberId_fkey`;

-- DropForeignKey
ALTER TABLE `user_phone_number` DROP FOREIGN KEY `user_phone_number_userId_fkey`;

-- DropForeignKey
ALTER TABLE `user_profile` DROP FOREIGN KEY `user_profile_profileId_fkey`;

-- DropForeignKey
ALTER TABLE `user_profile` DROP FOREIGN KEY `user_profile_userId_fkey`;

-- DropTable
DROP TABLE `courts_schedule`;

-- DropTable
DROP TABLE `event`;

-- DropTable
DROP TABLE `permission`;

-- DropTable
DROP TABLE `phone_number`;

-- DropTable
DROP TABLE `profile`;

-- DropTable
DROP TABLE `schedule`;

-- DropTable
DROP TABLE `user`;

-- DropTable
DROP TABLE `user_phone_number`;

-- DropTable
DROP TABLE `user_profile`;

-- CreateTable
CREATE TABLE `permissions` (
    `id` VARCHAR(191) NOT NULL,
    `permission` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `profiles` (
    `id` VARCHAR(191) NOT NULL,
    `ProfileName` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `users_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_profiles` (
    `id` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `profileId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `user_profiles_id_key`(`id`),
    PRIMARY KEY (`userId`, `profileId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `phone_numbers` (
    `id` VARCHAR(191) NOT NULL,
    `number` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_phone_numbers` (
    `id` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `phoneNumberId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `user_phone_numbers_id_key`(`id`),
    PRIMARY KEY (`userId`, `phoneNumberId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `events` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `schedules` (
    `id` VARCHAR(191) NOT NULL,
    `data` VARCHAR(191) NOT NULL,
    `statusId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `courts_schedules` (
    `id` VARCHAR(191) NOT NULL,
    `courtsId` VARCHAR(191) NOT NULL,
    `scheduleId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `courts_schedules_id_key`(`id`),
    PRIMARY KEY (`courtsId`, `scheduleId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `profile_permission` ADD CONSTRAINT `profile_permission_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `profile_permission` ADD CONSTRAINT `profile_permission_permissionId_fkey` FOREIGN KEY (`permissionId`) REFERENCES `permissions`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_profiles` ADD CONSTRAINT `user_profiles_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_profiles` ADD CONSTRAINT `user_profiles_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_phone_numbers` ADD CONSTRAINT `user_phone_numbers_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_phone_numbers` ADD CONSTRAINT `user_phone_numbers_phoneNumberId_fkey` FOREIGN KEY (`phoneNumberId`) REFERENCES `phone_numbers`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `event_status` ADD CONSTRAINT `event_status_eventId_fkey` FOREIGN KEY (`eventId`) REFERENCES `events`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `courts` ADD CONSTRAINT `courts_scheduleId_fkey` FOREIGN KEY (`scheduleId`) REFERENCES `schedules`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `courts_schedules` ADD CONSTRAINT `courts_schedules_courtsId_fkey` FOREIGN KEY (`courtsId`) REFERENCES `courts`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `courts_schedules` ADD CONSTRAINT `courts_schedules_scheduleId_fkey` FOREIGN KEY (`scheduleId`) REFERENCES `schedules`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
