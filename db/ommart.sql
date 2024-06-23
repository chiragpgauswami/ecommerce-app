-- phpMyAdmin SQL Dump
-- version 5.3.0-dev+20220917.b9499b51c8
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 18, 2022 at 03:38 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ommart`
--

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `pimgname` varchar(250) NOT NULL,
  `pname` varchar(250) NOT NULL,
  `price` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `pimgname`, `pname`, `price`) VALUES
(1, '1.jpg', 'Britannia Rusk', 50.00),
(2, '2.jpg', 'Madhur Sugar 1 KG', 45.00),
(3, '3.jpg', 'Kellogg\'s Corn Flakes 1 KG', 500.00),
(4, '4.jpg', 'Tata Salt 1 KG', 30.00),
(5, '5.jpg', 'Mom\'s Magic Biscuits', 120.00),
(6, '6.jpg', 'Fresh Apple 1 KG', 200.00),
(7, '7.jpg', 'Fresh Pomegranate 1 KG', 150.00),
(8, '8.jpg', 'Amul Butter 500 g (Carton)', 245.00),
(12, '9.jpg', 'Tide Powder 5 kg + 1 kg Free', 637.00),
(13, '10.jpg', 'Aashirvaad Superior MP Whole Wheat Atta 10 kg', 459.00),
(25, '11.jpg', 'Parle-G Original Glucose Biscuits 800 g', 76.00),
(26, '12.jpg', 'Pears Pure & Gentle Soap 125 g (Pack of 3)', 168.00),
(27, '13.jpg', 'Kissan Mixed Fruit Jam 700 g', 188.00),
(28, '14.jpg', 'Cadbury Dairy Milk Lickables Chocolate 20 g', 40.00),
(29, '15.jpg', 'Lotte Creamfilled Choco Pie 28 g (Pack of 12)', 99.00),
(30, '16.jpg', 'Lay\'s American Style Cream & Onion Potato Chips 115 g', 33.00),
(31, '17.jpg', 'Bingo Original Style Chilli Sprinkled Potato Chips 100 g', 45.00),
(32, '18.jpg', 'Act II Classic Salted Instant Popcorn 30 g', 10.00),
(33, '19.jpg', 'Bikaji Tana Bana Khatta Meetha 1 kg', 175.00),
(34, '20.jpg', 'Maggi Masala Ae Magic 6 g (Pack of 12)', 48.00),
(35, '21.jpg', 'Smith & Jones Ginger Garlic Paste 200 g', 39.00);

-- --------------------------------------------------------

--
-- Table structure for table `tblcart`
--

CREATE TABLE `tblcart` (
  `id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` varchar(200) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `product_id` int(11) NOT NULL,
  `mrp_price` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tblorders`
--

CREATE TABLE `tblorders` (
  `id` int(11) NOT NULL,
  `order_no` int(11) DEFAULT NULL,
  `customer_name` varchar(200) DEFAULT NULL,
  `product_name` varchar(400) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `product_price` varchar(100) DEFAULT NULL,
  `product_total_price` varchar(100) DEFAULT NULL,
  `order_status` varchar(100) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblorders`
--

INSERT INTO `tblorders` (`id`, `order_no`, `customer_name`, `product_name`, `quantity`, `product_price`, `product_total_price`, `order_status`, `image`, `order_date`) VALUES
(3, 1001, 'admin', 'Britannia Rusk', 4, '50.0', '200.0', 'Pending', '1.jpg', '2022-09-18 11:18:07'),
(4, 1002, 'admin', 'Madhur Sugar 1 KG', 1, '45.0', '45.0', 'Pending', '2.jpg', '2022-09-18 11:18:07'),
(5, 1003, 'admin', 'Kellogg\'s Corn Flakes 1 KG', 1, '500.0', '500.0', 'Pending', '3.jpg', '2022-09-18 11:18:07');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `uname` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `uname`, `password`, `role`) VALUES
(1, 'admin', 'admin', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblcart`
--
ALTER TABLE `tblcart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `tblorders`
--
ALTER TABLE `tblorders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `tblcart`
--
ALTER TABLE `tblcart`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tblorders`
--
ALTER TABLE `tblorders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblcart`
--
ALTER TABLE `tblcart`
  ADD CONSTRAINT `tblcart_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
