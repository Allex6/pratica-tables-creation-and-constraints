CREATE TABLE "customers" (
	"id" SERIAL PRIMARY KEY,
	"fullName" VARCHAR(100) NOT NULL,
	"cpf" VARCHAR(11) UNIQUE NOT NULL,
	"email" VARCHAR(50) UNIQUE NOT NULL,
	"password" TEXT NOT NULL
);

CREATE TYPE "customerPhoneType" AS ENUM('landline', 'mobile');

CREATE TABLE "customerPhones" (
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
	"number" VARCHAR(13) NOT NULL,
	"type" "customerPhoneType" DEFAULT 'mobile'
);

CREATE TABLE "states" (
	"id" SERIAL PRIMARY KEY,
	"name" TEXT NOT NULL
);

CREATE TABLE "cities" (
	"id" SERIAL PRIMARY KEY,
	"name" TEXT NOT NULL,
	"stateId" INTEGER NOT NULL REFERENCES "states"("id")
);

CREATE TABLE "customerAdresses" (
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
	"street" TEXT NOT NULL,
	"number" INTEGER,
	"complement" TEXT,
	"postalCode" VARCHAR(8) NOT NULL,
	"cityId" INTEGER NOT NULL REFERENCES "cities"("id")
);

CREATE TABLE "bankAccount" (
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
	"accountNumber" VARCHAR(20) NOT NULL UNIQUE,
	"agency" VARCHAR(10) NOT NULL,
	"openDate" DATE NOT NULL,
	"closeDate" DATE
);

CREATE TYPE "transactionType" AS ENUM ('deposit', 'withdrawn');

CREATE TABLE "transactions" (
	"id" SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
	"amount" DOUBLE PRECISION NOT NULL,
	"type" "transactionType",
	"time" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
	"description" TEXT,
	"cancelled" BOOLEAN DEFAULT FALSE
);

CREATE TABLE "creditCards" (
	"id" SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
	"name" VARCHAR(100) NOT NULL,
	"number" VARCHAR(16) NOT NULL UNIQUE,
	"securityCode" VARCHAR(3) NOT NULL,
	"expirationMonth" VARCHAR(2) NOT NULL,
	"expirationYear" VARCHAR(4) NOT NULL,
	"password" TEXT NOT NULL,
	"limit" DOUBLE PRECISION NOT NULL
);