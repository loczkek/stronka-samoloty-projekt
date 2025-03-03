-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 03 Mar 2025, 14:43
-- Wersja serwera: 10.4.22-MariaDB
-- Wersja PHP: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `samoloty`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `aircrafts`
--

CREATE TABLE `aircrafts` (
  `aircraftId` int(11) NOT NULL,
  `registrationNumber` varchar(50) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `manufacturer` varchar(100) DEFAULT NULL,
  `yearOfManufacture` year(4) DEFAULT NULL,
  `ownerID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `camo_certificates`
--

CREATE TABLE `camo_certificates` (
  `certificateID` int(11) NOT NULL,
  `aircraftID` int(11) NOT NULL,
  `issuedDate` date NOT NULL,
  `expirationDate` date NOT NULL,
  `status` enum('Active','Expired','Pending') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `clients`
--

CREATE TABLE `clients` (
  `clientId` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `clientType` enum('private','company') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `employees`
--

CREATE TABLE `employees` (
  `employeeID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `role` enum('Technician','Inspector','Sales Representative','Admin') NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `invoices`
--

CREATE TABLE `invoices` (
  `invoiceID` int(11) NOT NULL,
  `clientID` int(11) NOT NULL,
  `issueDate` date NOT NULL,
  `dueDate` date NOT NULL,
  `totalAmount` decimal(12,2) NOT NULL,
  `status` enum('Paid','Pending','Overdue') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `maintenance`
--

CREATE TABLE `maintenance` (
  `maintenanceID` int(11) NOT NULL,
  `aircraftID` int(11) NOT NULL,
  `performedDate` date NOT NULL,
  `description` text NOT NULL,
  `nextDueDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rentals`
--

CREATE TABLE `rentals` (
  `rentalId` int(11) NOT NULL,
  `aircraftId` int(11) DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `sales`
--

CREATE TABLE `sales` (
  `saleId` int(11) NOT NULL,
  `aircraftId` int(11) DEFAULT NULL,
  `buyerId` int(11) DEFAULT NULL,
  `saleDate` date DEFAULT NULL,
  `salePrice` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `aircrafts`
--
ALTER TABLE `aircrafts`
  ADD PRIMARY KEY (`aircraftId`),
  ADD UNIQUE KEY `registrationNumber` (`registrationNumber`),
  ADD KEY `OwnerID` (`ownerID`);

--
-- Indeksy dla tabeli `camo_certificates`
--
ALTER TABLE `camo_certificates`
  ADD PRIMARY KEY (`certificateID`),
  ADD KEY `AircraftID` (`aircraftID`);

--
-- Indeksy dla tabeli `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`clientId`);

--
-- Indeksy dla tabeli `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employeeID`),
  ADD UNIQUE KEY `Email` (`email`);

--
-- Indeksy dla tabeli `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoiceID`),
  ADD KEY `ClientID` (`clientID`);

--
-- Indeksy dla tabeli `maintenance`
--
ALTER TABLE `maintenance`
  ADD PRIMARY KEY (`maintenanceID`),
  ADD KEY `AircraftID` (`aircraftID`);

--
-- Indeksy dla tabeli `rentals`
--
ALTER TABLE `rentals`
  ADD PRIMARY KEY (`rentalId`),
  ADD KEY `aircraftId` (`aircraftId`),
  ADD KEY `clientId` (`clientId`);

--
-- Indeksy dla tabeli `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`saleId`),
  ADD KEY `aircraftId` (`aircraftId`),
  ADD KEY `buyerId` (`buyerId`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `aircrafts`
--
ALTER TABLE `aircrafts`
  MODIFY `aircraftId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `camo_certificates`
--
ALTER TABLE `camo_certificates`
  MODIFY `certificateID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `clients`
--
ALTER TABLE `clients`
  MODIFY `clientId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `employees`
--
ALTER TABLE `employees`
  MODIFY `employeeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoiceID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `maintenance`
--
ALTER TABLE `maintenance`
  MODIFY `maintenanceID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `rentals`
--
ALTER TABLE `rentals`
  MODIFY `rentalId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `sales`
--
ALTER TABLE `sales`
  MODIFY `saleId` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `aircrafts`
--
ALTER TABLE `aircrafts`
  ADD CONSTRAINT `aircrafts_ibfk_1` FOREIGN KEY (`OwnerID`) REFERENCES `clients` (`clientId`);

--
-- Ograniczenia dla tabeli `camo_certificates`
--
ALTER TABLE `camo_certificates`
  ADD CONSTRAINT `camo_certificates_ibfk_1` FOREIGN KEY (`AircraftID`) REFERENCES `aircrafts` (`aircraftId`);

--
-- Ograniczenia dla tabeli `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `clients` (`clientId`);

--
-- Ograniczenia dla tabeli `maintenance`
--
ALTER TABLE `maintenance`
  ADD CONSTRAINT `maintenance_ibfk_1` FOREIGN KEY (`AircraftID`) REFERENCES `aircrafts` (`aircraftId`);

--
-- Ograniczenia dla tabeli `rentals`
--
ALTER TABLE `rentals`
  ADD CONSTRAINT `rentals_ibfk_1` FOREIGN KEY (`aircraftId`) REFERENCES `aircrafts` (`aircraftId`),
  ADD CONSTRAINT `rentals_ibfk_2` FOREIGN KEY (`clientId`) REFERENCES `clients` (`clientId`);

--
-- Ograniczenia dla tabeli `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`aircraftId`) REFERENCES `aircrafts` (`aircraftId`),
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`buyerId`) REFERENCES `clients` (`clientId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
