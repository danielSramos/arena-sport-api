/*
  Warnings:

  - You are about to drop the `profile_permission` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `profile_permission` DROP FOREIGN KEY `profile_permission_permissionId_fkey`;

-- DropForeignKey
ALTER TABLE `profile_permission` DROP FOREIGN KEY `profile_permission_profileId_fkey`;

-- DropTable
DROP TABLE `profile_permission`;

-- CreateTable
CREATE TABLE `profile_permissions` (
    `profileId` VARCHAR(191) NOT NULL,
    `permissionId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`profileId`, `permissionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `profile_permissions` ADD CONSTRAINT `profile_permissions_profileId_fkey` FOREIGN KEY (`profileId`) REFERENCES `profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `profile_permissions` ADD CONSTRAINT `profile_permissions_permissionId_fkey` FOREIGN KEY (`permissionId`) REFERENCES `permissions`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
