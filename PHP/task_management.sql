-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 04, 2025 at 12:55 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `task_management`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_task` (IN `p_user_id` INT, IN `p_title` VARCHAR(100), IN `p_description` TEXT, IN `p_duration` VARCHAR(255))   BEGIN
    INSERT INTO tasks (user_id, title, description, duration) 
    VALUES (p_user_id, p_title, p_description, p_duration);
    SELECT 'Task added successfully' AS message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_login` (IN `p_username` VARCHAR(50), IN `p_password` VARCHAR(255))   BEGIN
    DECLARE db_password VARCHAR(255);
    DECLARE user_id INT;
    
    SELECT id, password INTO user_id, db_password 
    FROM users WHERE username = p_username;
    
    IF db_password IS NULL THEN
        SELECT 'User not found' AS message, 0 AS success;
    ELSEIF NOT (p_password = db_password) THEN
        SELECT 'Invalid password' AS message, 0 AS success;
    ELSE
        SELECT 'Login successful' AS message, user_id AS success;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_task` (IN `p_task_id` INT)   BEGIN
    DELETE FROM tasks WHERE id = p_task_id;
    SELECT 'Task deleted successfully' AS message;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_all_tasks` ()   BEGIN
    SELECT * FROM tasks;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_tasks_by_status` (IN `p_status` ENUM('pending','completed'))   BEGIN
    SELECT * FROM tasks WHERE status = p_status;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_user` (IN `p_username` VARCHAR(50), IN `p_email` VARCHAR(100), IN `p_password` VARCHAR(255))   BEGIN
    IF EXISTS (SELECT * FROM users WHERE email = p_email OR username = p_username) THEN
        SELECT 'User already exists' AS message;
    ELSE
        INSERT INTO users (username, email, password) 
        VALUES (p_username, p_email, p_password);
        SELECT 'User registered successfully' AS message;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_task_status` (IN `p_task_id` INT, IN `p_status` ENUM('pending','completed'))   BEGIN
    UPDATE tasks SET status = p_status WHERE id = p_task_id;
    SELECT 'Task status updated successfully' AS message;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `duration` text DEFAULT NULL,
  `status` enum('pending','complete') DEFAULT NULL,
  `created_at` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `user_id`, `title`, `description`, `duration`, `status`, `created_at`) VALUES
(2, 13, 'Recording video', 'maxmed nuur shaqadan qabo', '13', 'complete', '2025-01-01'),
(3, NULL, 'system samayn', 'mudane system kan same', '21', 'complete', '2025-01-01'),
(4, NULL, 'guri dhisid', 'war nio gurigan dhis', '21', 'complete', '2025-01-01'),
(5, NULL, 'coloring', 'improving system colors', '2', 'complete', '2025-01-01'),
(6, 17, 'midab', 'midabeyn', '21', 'pending', '2025-01-02'),
(7, NULL, 'assignment', '20 marks iska dhig', '21', 'complete', '2025-01-02');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `created_at`) VALUES
(1, 'muuse', 'muuse@gmail.com', '12', '2024-12-10 04:03:00'),
(2, 'farax maxamed', 'farax@gmail.com', '123', '2024-12-12 04:33:12'),
(12, 'anfac', 'anfac@gmail.com', '12', '2024-12-23 21:51:55'),
(13, 'maxamed mahad', 'maxamed@gmail.com', '123', '2024-12-31 05:13:58'),
(15, 'maxmed nuur', 'enjoa500@gmail.com', '12', '2025-01-01 17:56:29'),
(16, 'abdrisaq', 'anshaxshiqxuseen@gmail.com', '12', '2025-01-02 05:01:20'),
(17, 'abdullaahi', 'taskmanagers78@gmail.com', '12', '2025-01-02 18:23:01'),
(18, 'ustad adnaan', 'ajnabii3333@gmail.com', '12', '2025-01-02 20:30:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
