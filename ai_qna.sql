-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2025 at 08:13 AM
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
-- Database: `ai_qna`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `email`, `password`, `created_at`) VALUES
(1, 'AKASH HIREMATH', 'arh241875@gmail.com', '$2b$12$Yz9J1qFK6SRYrZqD6Bf2FuxUxwKL91eJE41Uxm5NMaAWQ79mPKs52', '2025-03-04 13:12:38');

-- --------------------------------------------------------

--
-- Table structure for table `meetings`
--

CREATE TABLE `meetings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `meet_link` varchar(255) NOT NULL,
  `meet_date` date NOT NULL,
  `meet_time` time NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meetings`
--

INSERT INTO `meetings` (`id`, `user_id`, `meet_link`, `meet_date`, `meet_time`, `created_at`) VALUES
(1, 1, 'https://meet.google.com/dzo-rjev-ovs', '2025-03-06', '11:30:00', '2025-03-05 05:07:50'),
(2, 1, 'https://meet.google.com/kmc-dusq-qpj', '2025-03-13', '10:45:00', '2025-03-12 13:15:45');

-- --------------------------------------------------------

--
-- Table structure for table `mock_tests`
--

CREATE TABLE `mock_tests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `user_answer` text DEFAULT NULL,
  `score` float DEFAULT 0,
  `test_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mock_tests`
--

INSERT INTO `mock_tests` (`id`, `user_id`, `category`, `question`, `answer`, `user_answer`, `score`, `test_date`) VALUES
(1, 1, 'CSS', 'What is the difference between relative and absolute units in CSS?', 'CSS is a markup language like HTML.', '1', -0.07, '2025-03-04 13:11:24');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `question` text DEFAULT NULL,
  `answer` text DEFAULT NULL,
  `score` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `category`, `question`, `answer`, `score`) VALUES
(1, 'Cloud Computing', 'What is Cloud Computing?', 'Cloud computing is the delivery of computing services over the internet.', 1),
(2, 'Cloud Computing', 'What is Cloud Computing?', 'Cloud computing provides computing resources via the internet.', 0.8),
(3, 'Cloud Computing', 'What is Cloud Computing?', 'It is a type of local storage.', 0),
(4, 'Cloud Computing', 'What are the main types of cloud computing?', 'Public, Private, and Hybrid clouds.', 1),
(5, 'Cloud Computing', 'What are the main types of cloud computing?', 'It allows remote access to computing services.', 0.8),
(6, 'Cloud Computing', 'What are the main types of cloud computing?', 'Only involves physical servers.', 0),
(7, 'Cloud Computing', 'What is IaaS?', 'Infrastructure as a Service provides virtualized computing resources.', 1),
(8, 'Cloud Computing', 'What is IaaS?', 'A method of utilizing virtual computing infrastructure online.', 0.8),
(9, 'Cloud Computing', 'What is IaaS?', 'It is an operating system.', 0),
(10, 'Cloud Computing', 'What is PaaS?', 'Platform as a Service offers a development environment on the cloud.', 1),
(11, 'Cloud Computing', 'What is PaaS?', 'Cloud computing provides computing resources via the internet.', 0.8),
(12, 'Cloud Computing', 'What is PaaS?', 'It is a type of local storage.', 0),
(13, 'Cloud Computing', 'What is SaaS?', 'Software as a Service provides applications over the internet.', 1),
(14, 'Cloud Computing', 'What is SaaS?', 'It allows remote access to computing services.', 0.8),
(15, 'Cloud Computing', 'What is SaaS?', 'Only involves physical servers.', 0),
(16, 'Cloud Computing', 'What is a cloud service provider?', 'A company offering cloud computing services, e.g., AWS, Azure, GCP.', 1),
(17, 'Cloud Computing', 'What is a cloud service provider?', 'A method of utilizing virtual computing infrastructure online.', 0.8),
(18, 'Cloud Computing', 'What is a cloud service provider?', 'It is an operating system.', 0),
(19, 'Cloud Computing', 'What is cloud storage?', 'Storing data remotely on the internet rather than local devices.', 1),
(20, 'Cloud Computing', 'What is cloud storage?', 'Cloud computing provides computing resources via the internet.', 0.8),
(21, 'Cloud Computing', 'What is cloud storage?', 'It is a type of local storage.', 0),
(22, 'Cloud Computing', 'What is serverless computing?', 'A cloud computing model where the provider manages the infrastructure.', 1),
(23, 'Cloud Computing', 'What is serverless computing?', 'It allows remote access to computing services.', 0.8),
(24, 'Cloud Computing', 'What is serverless computing?', 'Only involves physical servers.', 0),
(25, 'Cloud Computing', 'What is virtualization in cloud computing?', 'The creation of virtual machines for efficient resource utilization.', 1),
(26, 'Cloud Computing', 'What is virtualization in cloud computing?', 'A method of utilizing virtual computing infrastructure online.', 0.8),
(27, 'Cloud Computing', 'What is virtualization in cloud computing?', 'It is an operating system.', 0),
(28, 'Cloud Computing', 'What is the difference between private and public clouds?', 'Private clouds are used by a single organization; public clouds are shared.', 1),
(29, 'Cloud Computing', 'What is the difference between private and public clouds?', 'Cloud computing provides computing resources via the internet.', 0.8),
(30, 'Cloud Computing', 'What is the difference between private and public clouds?', 'It is a type of local storage.', 0),
(31, 'Cloud Computing', 'What is a hybrid cloud?', 'A combination of private and public clouds for flexibility.', 1),
(32, 'Cloud Computing', 'What is a hybrid cloud?', 'It allows remote access to computing services.', 0.8),
(33, 'Cloud Computing', 'What is a hybrid cloud?', 'Only involves physical servers.', 0),
(34, 'Cloud Computing', 'What is multi-cloud?', 'Using multiple cloud service providers for redundancy.', 1),
(35, 'Cloud Computing', 'What is multi-cloud?', 'A method of utilizing virtual computing infrastructure online.', 0.8),
(36, 'Cloud Computing', 'What is multi-cloud?', 'It is an operating system.', 0),
(37, 'Cloud Computing', 'What is edge computing?', 'Processing data closer to the source rather than relying on centralized cloud servers.', 1),
(38, 'Cloud Computing', 'What is edge computing?', 'Cloud computing provides computing resources via the internet.', 0.8),
(39, 'Cloud Computing', 'What is edge computing?', 'It is a type of local storage.', 0),
(40, 'Cloud Computing', 'What is cloud elasticity?', 'The ability to automatically scale computing resources up or down.', 1),
(41, 'Cloud Computing', 'What is cloud elasticity?', 'It allows remote access to computing services.', 0.8),
(42, 'Cloud Computing', 'What is cloud elasticity?', 'Only involves physical servers.', 0),
(43, 'Cloud Computing', 'What is a cloud-native application?', 'An application designed to run in a cloud environment.', 1),
(44, 'Cloud Computing', 'What is a cloud-native application?', 'A method of utilizing virtual computing infrastructure online.', 0.8),
(45, 'Cloud Computing', 'What is a cloud-native application?', 'It is an operating system.', 0),
(46, 'Cloud Computing', 'What is cloud security?', 'Protecting cloud data, applications, and infrastructure from threats.', 1),
(47, 'Cloud Computing', 'What is cloud security?', 'Cloud computing provides computing resources via the internet.', 0.8),
(48, 'Cloud Computing', 'What is cloud security?', 'It is a type of local storage.', 0),
(49, 'Cloud Computing', 'What are containers in cloud computing?', 'Lightweight, portable environments for running applications.', 1),
(50, 'Cloud Computing', 'What are containers in cloud computing?', 'It allows remote access to computing services.', 0.8),
(51, 'Cloud Computing', 'What are containers in cloud computing?', 'Only involves physical servers.', 0),
(52, 'Cloud Computing', 'What is Kubernetes?', 'An open-source container orchestration platform.', 1),
(53, 'Cloud Computing', 'What is Kubernetes?', 'A method of utilizing virtual computing infrastructure online.', 0.8),
(54, 'Cloud Computing', 'What is Kubernetes?', 'It is an operating system.', 0),
(55, 'Cloud Computing', 'What is an API gateway in cloud computing?', 'A tool that manages API requests in a cloud environment.', 1),
(56, 'Cloud Computing', 'What is an API gateway in cloud computing?', 'Cloud computing provides computing resources via the internet.', 0.8),
(57, 'Cloud Computing', 'What is an API gateway in cloud computing?', 'It is a type of local storage.', 0),
(58, 'Cloud Computing', 'What is a cloud CDN?', 'A content delivery network that accelerates content delivery via edge servers.', 1),
(59, 'Cloud Computing', 'What is a cloud CDN?', 'It allows remote access to computing services.', 0.8),
(60, 'Cloud Computing', 'What is a cloud CDN?', 'Only involves physical servers.', 0),
(61, 'Java', 'What is Java?', 'Java is a high-level, object-oriented programming language.', 1),
(62, 'Java', 'What is Java?', 'Java is an object-oriented programming language.', 0.8),
(63, 'Java', 'What is Java?', 'It is a type of coffee.', 0),
(64, 'Java', 'What is JVM?', 'JVM stands for Java Virtual Machine, which runs Java bytecode.', 1),
(65, 'Java', 'What is JVM?', 'A high-level programming language running on JVM.', 0.8),
(66, 'Java', 'What is JVM?', 'A scripting language used for web pages.', 0),
(67, 'Java', 'What is JRE?', 'Java Runtime Environment provides the libraries required to run Java applications.', 1),
(68, 'Java', 'What is JRE?', 'A language designed for platform independence.', 0.8),
(69, 'Java', 'What is JRE?', 'A markup language for web development.', 0),
(70, 'Java', 'What is JDK?', 'Java Development Kit includes JRE and development tools.', 1),
(71, 'Java', 'What is JDK?', 'Java is an object-oriented programming language.', 0.8),
(72, 'Java', 'What is JDK?', 'It is a type of coffee.', 0),
(73, 'Java', 'What is bytecode?', 'A compiled Java file that runs on the JVM.', 1),
(74, 'Java', 'What is bytecode?', 'A high-level programming language running on JVM.', 0.8),
(75, 'Java', 'What is bytecode?', 'A scripting language used for web pages.', 0),
(76, 'Java', 'What is a class in Java?', 'A blueprint for creating objects.', 1),
(77, 'Java', 'What is a class in Java?', 'A language designed for platform independence.', 0.8),
(78, 'Java', 'What is a class in Java?', 'A markup language for web development.', 0),
(79, 'Java', 'What is an object in Java?', 'An instance of a class with state and behavior.', 1),
(80, 'Java', 'What is an object in Java?', 'Java is an object-oriented programming language.', 0.8),
(81, 'Java', 'What is an object in Java?', 'It is a type of coffee.', 0),
(82, 'Java', 'What are Java data types?', 'Primitive (int, double) and non-primitive (arrays, classes).', 1),
(83, 'Java', 'What are Java data types?', 'A high-level programming language running on JVM.', 0.8),
(84, 'Java', 'What are Java data types?', 'A scripting language used for web pages.', 0),
(85, 'Java', 'What is inheritance in Java?', 'A mechanism where a class acquires properties of another class.', 1),
(86, 'Java', 'What is inheritance in Java?', 'A language designed for platform independence.', 0.8),
(87, 'Java', 'What is inheritance in Java?', 'A markup language for web development.', 0),
(88, 'Java', 'What is polymorphism?', 'The ability of a function to take multiple forms.', 1),
(89, 'Java', 'What is polymorphism?', 'Java is an object-oriented programming language.', 0.8),
(90, 'Java', 'What is polymorphism?', 'It is a type of coffee.', 0),
(91, 'Java', 'What is encapsulation?', 'Bundling of data and methods within a class.', 1),
(92, 'Java', 'What is encapsulation?', 'A high-level programming language running on JVM.', 0.8),
(93, 'Java', 'What is encapsulation?', 'A scripting language used for web pages.', 0),
(94, 'Java', 'What is abstraction?', 'Hiding implementation details and showing only necessary features.', 1),
(95, 'Java', 'What is abstraction?', 'A language designed for platform independence.', 0.8),
(96, 'Java', 'What is abstraction?', 'A markup language for web development.', 0),
(97, 'Java', 'What is an interface?', 'A reference type in Java that defines methods but has no implementation.', 1),
(98, 'Java', 'What is an interface?', 'Java is an object-oriented programming language.', 0.8),
(99, 'Java', 'What is an interface?', 'It is a type of coffee.', 0),
(100, 'Java', 'What is the difference between abstract class and interface?', 'Abstract classes can have method implementations; interfaces cannot.', 1),
(101, 'Java', 'What is the difference between abstract class and interface?', 'A high-level programming language running on JVM.', 0.8),
(102, 'Java', 'What is the difference between abstract class and interface?', 'A scripting language used for web pages.', 0),
(103, 'Java', 'What are access modifiers in Java?', 'Public, private, protected, and default define access control.', 1),
(104, 'Java', 'What are access modifiers in Java?', 'A language designed for platform independence.', 0.8),
(105, 'Java', 'What are access modifiers in Java?', 'A markup language for web development.', 0),
(106, 'Java', 'What is final keyword in Java?', 'It prevents modification of a variable, method, or class.', 1),
(107, 'Java', 'What is final keyword in Java?', 'Java is an object-oriented programming language.', 0.8),
(108, 'Java', 'What is final keyword in Java?', 'It is a type of coffee.', 0),
(109, 'Java', 'What is exception handling?', 'A mechanism to handle runtime errors using try-catch blocks.', 1),
(110, 'Java', 'What is exception handling?', 'A high-level programming language running on JVM.', 0.8),
(111, 'Java', 'What is exception handling?', 'A scripting language used for web pages.', 0),
(112, 'Java', 'What is multithreading in Java?', 'Executing multiple threads concurrently for parallel execution.', 1),
(113, 'Java', 'What is multithreading in Java?', 'A language designed for platform independence.', 0.8),
(114, 'Java', 'What is multithreading in Java?', 'A markup language for web development.', 0),
(115, 'Java', 'What is garbage collection?', 'Automatic memory management by reclaiming unused objects.', 1),
(116, 'Java', 'What is garbage collection?', 'Java is an object-oriented programming language.', 0.8),
(117, 'Java', 'What is garbage collection?', 'It is a type of coffee.', 0),
(118, 'Java', 'What is the difference between HashMap and Hashtable?', 'HashMap is non-synchronized; Hashtable is synchronized.', 1),
(119, 'Java', 'What is the difference between HashMap and Hashtable?', 'A high-level programming language running on JVM.', 0.8),
(120, 'Java', 'What is the difference between HashMap and Hashtable?', 'A scripting language used for web pages.', 0),
(121, 'Full Stack', 'What is Full Stack Development?', 'It involves both front-end and back-end development.', 1),
(122, 'Full Stack', 'What is Full Stack Development?', 'Full Stack Development involves both client-side and server-side.', 0.8),
(123, 'Full Stack', 'What is Full Stack Development?', 'Only focuses on front-end design.', 0),
(124, 'Full Stack', 'What are front-end technologies?', 'HTML, CSS, JavaScript, React, Angular.', 1),
(125, 'Full Stack', 'What are front-end technologies?', 'A role requiring front-end and back-end skills.', 0.8),
(126, 'Full Stack', 'What are front-end technologies?', 'A database management technology.', 0),
(127, 'Full Stack', 'What are back-end technologies?', 'Node.js, Python, Java, PHP, .NET.', 1),
(128, 'Full Stack', 'What are back-end technologies?', 'Developing applications that include UI and databases.', 0.8),
(129, 'Full Stack', 'What are back-end technologies?', 'A specific type of software library.', 0),
(130, 'Full Stack', 'What is a database?', 'A system for storing and managing data.', 1),
(131, 'Full Stack', 'What is a database?', 'Full Stack Development involves both client-side and server-side.', 0.8),
(132, 'Full Stack', 'What is a database?', 'Only focuses on front-end design.', 0),
(133, 'Full Stack', 'What is REST API?', 'A way to communicate between client and server using HTTP.', 1),
(134, 'Full Stack', 'What is REST API?', 'A role requiring front-end and back-end skills.', 0.8),
(135, 'Full Stack', 'What is REST API?', 'A database management technology.', 0),
(136, 'Full Stack', 'What is MVC architecture?', 'Model-View-Controller separates concerns in software design.', 1),
(137, 'Full Stack', 'What is MVC architecture?', 'Developing applications that include UI and databases.', 0.8),
(138, 'Full Stack', 'What is MVC architecture?', 'A specific type of software library.', 0),
(139, 'Full Stack', 'What is CRUD?', 'Create, Read, Update, Delete operations on a database.', 1),
(140, 'Full Stack', 'What is CRUD?', 'Full Stack Development involves both client-side and server-side.', 0.8),
(141, 'Full Stack', 'What is CRUD?', 'Only focuses on front-end design.', 0),
(142, 'Full Stack', 'What is Node.js?', 'A JavaScript runtime used for back-end development.', 1),
(143, 'Full Stack', 'What is Node.js?', 'A role requiring front-end and back-end skills.', 0.8),
(144, 'Full Stack', 'What is Node.js?', 'A database management technology.', 0),
(145, 'Full Stack', 'What is Express.js?', 'A web framework for Node.js.', 1),
(146, 'Full Stack', 'What is Express.js?', 'Developing applications that include UI and databases.', 0.8),
(147, 'Full Stack', 'What is Express.js?', 'A specific type of software library.', 0),
(148, 'Full Stack', 'What is React?', 'A JavaScript library for building user interfaces.', 1),
(149, 'Full Stack', 'What is React?', 'Full Stack Development involves both client-side and server-side.', 0.8),
(150, 'Full Stack', 'What is React?', 'Only focuses on front-end design.', 0),
(151, 'Full Stack', 'What is Angular?', 'A framework for building dynamic web applications.', 1),
(152, 'Full Stack', 'What is Angular?', 'A role requiring front-end and back-end skills.', 0.8),
(153, 'Full Stack', 'What is Angular?', 'A database management technology.', 0),
(154, 'Full Stack', 'What is a web server?', 'A server that processes HTTP requests from clients.', 1),
(155, 'Full Stack', 'What is a web server?', 'Developing applications that include UI and databases.', 0.8),
(156, 'Full Stack', 'What is a web server?', 'A specific type of software library.', 0),
(157, 'Full Stack', 'What is authentication?', 'Verifying user identity using credentials.', 1),
(158, 'Full Stack', 'What is authentication?', 'Full Stack Development involves both client-side and server-side.', 0.8),
(159, 'Full Stack', 'What is authentication?', 'Only focuses on front-end design.', 0),
(160, 'Full Stack', 'What is authorization?', 'Granting access based on permissions.', 1),
(161, 'Full Stack', 'What is authorization?', 'A role requiring front-end and back-end skills.', 0.8),
(162, 'Full Stack', 'What is authorization?', 'A database management technology.', 0),
(163, 'Full Stack', 'What is JSON?', 'JavaScript Object Notation, a lightweight data format.', 1),
(164, 'Full Stack', 'What is JSON?', 'Developing applications that include UI and databases.', 0.8),
(165, 'Full Stack', 'What is JSON?', 'A specific type of software library.', 0),
(166, 'Full Stack', 'What is the difference between SQL and NoSQL?', 'SQL is structured; NoSQL is flexible for large-scale data.', 1),
(167, 'Full Stack', 'What is the difference between SQL and NoSQL?', 'Full Stack Development involves both client-side and server-side.', 0.8),
(168, 'Full Stack', 'What is the difference between SQL and NoSQL?', 'Only focuses on front-end design.', 0),
(169, 'Full Stack', 'What is DevOps?', 'A methodology that integrates development and operations.', 1),
(170, 'Full Stack', 'What is DevOps?', 'A role requiring front-end and back-end skills.', 0.8),
(171, 'Full Stack', 'What is DevOps?', 'A database management technology.', 0),
(172, 'Full Stack', 'What are microservices?', 'A software architecture that structures applications as a collection of services.', 1),
(173, 'Full Stack', 'What are microservices?', 'Developing applications that include UI and databases.', 0.8),
(174, 'Full Stack', 'What are microservices?', 'A specific type of software library.', 0),
(175, 'Full Stack', 'What is GraphQL?', 'A query language for APIs with flexible data fetching.', 1),
(176, 'Full Stack', 'What is GraphQL?', 'Full Stack Development involves both client-side and server-side.', 0.8),
(177, 'Full Stack', 'What is GraphQL?', 'Only focuses on front-end design.', 0),
(178, 'Full Stack', 'What is Docker?', 'A tool that allows applications to run in isolated containers.', 1),
(179, 'Full Stack', 'What is Docker?', 'A role requiring front-end and back-end skills.', 0.8),
(180, 'Full Stack', 'What is Docker?', 'A database management technology.', 0),
(181, 'Web Development', 'What is Web Development?', 'Web development is the process of creating websites.', 1),
(182, 'Web Development', 'What is Web Development?', 'Web development involves building websites using HTML, CSS, and JavaScript.', 0.8),
(183, 'Web Development', 'What is Web Development?', 'It only involves HTML.', 0),
(184, 'Web Development', 'What is HTML?', 'HTML stands for HyperText Markup Language.', 1),
(185, 'Web Development', 'What is HTML?', 'The process of creating interactive web applications.', 0.8),
(186, 'Web Development', 'What is HTML?', 'A term for hosting websites.', 0),
(187, 'Web Development', 'What is CSS?', 'CSS is used for styling web pages.', 1),
(188, 'Web Development', 'What is CSS?', 'A field that includes front-end and back-end web development.', 0.8),
(189, 'Web Development', 'What is CSS?', 'The process of making desktop applications.', 0),
(190, 'Web Development', 'What is JavaScript?', 'JavaScript is used for adding interactivity to web pages.', 1),
(191, 'Web Development', 'What is JavaScript?', 'Web development involves building websites using HTML, CSS, and JavaScript.', 0.8),
(192, 'Web Development', 'What is JavaScript?', 'It only involves HTML.', 0),
(193, 'Web Development', 'What is responsive design?', 'A design approach that ensures websites work on all devices.', 1),
(194, 'Web Development', 'What is responsive design?', 'The process of creating interactive web applications.', 0.8),
(195, 'Web Development', 'What is responsive design?', 'A term for hosting websites.', 0),
(196, 'Web Development', 'What is Bootstrap?', 'A CSS framework for responsive web design.', 1),
(197, 'Web Development', 'What is Bootstrap?', 'A field that includes front-end and back-end web development.', 0.8),
(198, 'Web Development', 'What is Bootstrap?', 'The process of making desktop applications.', 0),
(199, 'Web Development', 'What is a web framework?', 'A framework that simplifies web development (e.g., React, Angular).', 1),
(200, 'Web Development', 'What is a web framework?', 'Web development involves building websites using HTML, CSS, and JavaScript.', 0.8),
(201, 'Web Development', 'What is a web framework?', 'It only involves HTML.', 0),
(202, 'Web Development', 'What is SEO?', 'Search Engine Optimization improves website visibility in search engines.', 1),
(203, 'Web Development', 'What is SEO?', 'The process of creating interactive web applications.', 0.8),
(204, 'Web Development', 'What is SEO?', 'A term for hosting websites.', 0),
(205, 'Web Development', 'What is AJAX?', 'A technique for asynchronous web requests without refreshing pages.', 1),
(206, 'Web Development', 'What is AJAX?', 'A field that includes front-end and back-end web development.', 0.8),
(207, 'Web Development', 'What is AJAX?', 'The process of making desktop applications.', 0),
(208, 'Web Development', 'What is a CMS?', 'Content Management System like WordPress for managing website content.', 1),
(209, 'Web Development', 'What is a CMS?', 'Web development involves building websites using HTML, CSS, and JavaScript.', 0.8),
(210, 'Web Development', 'What is a CMS?', 'It only involves HTML.', 0),
(211, 'Web Development', 'What is a web API?', 'An interface that allows communication between different applications.', 1),
(212, 'Web Development', 'What is a web API?', 'The process of creating interactive web applications.', 0.8),
(213, 'Web Development', 'What is a web API?', 'A term for hosting websites.', 0),
(214, 'Web Development', 'What is a cookie?', 'A small data file stored by browsers for user tracking.', 1),
(215, 'Web Development', 'What is a cookie?', 'A field that includes front-end and back-end web development.', 0.8),
(216, 'Web Development', 'What is a cookie?', 'The process of making desktop applications.', 0),
(217, 'Web Development', 'What is local storage?', 'A browser feature for storing data persistently.', 1),
(218, 'Web Development', 'What is local storage?', 'Web development involves building websites using HTML, CSS, and JavaScript.', 0.8),
(219, 'Web Development', 'What is local storage?', 'It only involves HTML.', 0),
(220, 'Web Development', 'What is CORS?', 'Cross-Origin Resource Sharing allows web resources to be accessed from different domains.', 1),
(221, 'Web Development', 'What is CORS?', 'The process of creating interactive web applications.', 0.8),
(222, 'Web Development', 'What is CORS?', 'A term for hosting websites.', 0),
(223, 'Web Development', 'What is a progressive web app (PWA)?', 'A web application that works offline and behaves like a native app.', 1),
(224, 'Web Development', 'What is a progressive web app (PWA)?', 'A field that includes front-end and back-end web development.', 0.8),
(225, 'Web Development', 'What is a progressive web app (PWA)?', 'The process of making desktop applications.', 0),
(226, 'Web Development', 'What is a single-page application (SPA)?', 'A web app that loads a single HTML page dynamically.', 1),
(227, 'Web Development', 'What is a single-page application (SPA)?', 'Web development involves building websites using HTML, CSS, and JavaScript.', 0.8),
(228, 'Web Development', 'What is a single-page application (SPA)?', 'It only involves HTML.', 0),
(229, 'Web Development', 'What is HTTP?', 'HyperText Transfer Protocol governs communication between clients and servers.', 1),
(230, 'Web Development', 'What is HTTP?', 'The process of creating interactive web applications.', 0.8),
(231, 'Web Development', 'What is HTTP?', 'A term for hosting websites.', 0),
(232, 'Web Development', 'What is HTTPS?', 'A secure version of HTTP that encrypts data transmission.', 1),
(233, 'Web Development', 'What is HTTPS?', 'A field that includes front-end and back-end web development.', 0.8),
(234, 'Web Development', 'What is HTTPS?', 'The process of making desktop applications.', 0),
(235, 'Web Development', 'What is DNS?', 'Domain Name System translates domain names into IP addresses.', 1),
(236, 'Web Development', 'What is DNS?', 'Web development involves building websites using HTML, CSS, and JavaScript.', 0.8),
(237, 'Web Development', 'What is DNS?', 'It only involves HTML.', 0),
(238, 'Web Development', 'What is a web socket?', 'A protocol for real-time bidirectional communication between client and server.', 1),
(239, 'Web Development', 'What is a web socket?', 'The process of creating interactive web applications.', 0.8),
(240, 'Web Development', 'What is a web socket?', 'A term for hosting websites.', 0),
(241, 'CSS', 'What is CSS?', 'CSS stands for Cascading Style Sheets and is used for styling web pages.', 1),
(242, 'CSS', 'What is CSS?', 'CSS is used for styling web pages using selectors and properties.', 0.8),
(243, 'CSS', 'What is CSS?', 'CSS is a programming language for building websites.', 0),
(244, 'CSS', 'What are the different types of CSS?', 'Inline, Internal, and External CSS.', 1),
(245, 'CSS', 'What are the different types of CSS?', 'It includes rules to define how HTML elements are displayed.', 0.8),
(246, 'CSS', 'What are the different types of CSS?', 'CSS is used for writing server-side scripts.', 0),
(247, 'CSS', 'What is the difference between relative, absolute, and fixed positioning in CSS?', 'Relative is based on its normal position, absolute is based on the nearest positioned ancestor, and fixed is relative to the viewport.', 1),
(248, 'CSS', 'What is the difference between relative, absolute, and fixed positioning in CSS?', 'A language for adding styles like color and layout to webpages.', 0.8),
(249, 'CSS', 'What is the difference between relative, absolute, and fixed positioning in CSS?', 'CSS is a markup language like HTML.', 0),
(250, 'CSS', 'What is Flexbox in CSS?', 'A layout model that allows responsive arrangement of elements in a container.', 1),
(251, 'CSS', 'What is Flexbox in CSS?', 'CSS is used for styling web pages using selectors and properties.', 0.8),
(252, 'CSS', 'What is Flexbox in CSS?', 'CSS is a programming language for building websites.', 0),
(253, 'CSS', 'What is Grid Layout in CSS?', 'A two-dimensional layout system for designing web pages.', 1),
(254, 'CSS', 'What is Grid Layout in CSS?', 'It includes rules to define how HTML elements are displayed.', 0.8),
(255, 'CSS', 'What is Grid Layout in CSS?', 'CSS is used for writing server-side scripts.', 0),
(256, 'CSS', 'What is the difference between rem and em units in CSS?', 'rem is based on the root element\'s font size, while em is based on the parent element\'s font size.', 1),
(257, 'CSS', 'What is the difference between rem and em units in CSS?', 'A language for adding styles like color and layout to webpages.', 0.8),
(258, 'CSS', 'What is the difference between rem and em units in CSS?', 'CSS is a markup language like HTML.', 0),
(259, 'CSS', 'What is a media query in CSS?', 'A feature that allows CSS to adapt based on screen size and resolution.', 1),
(260, 'CSS', 'What is a media query in CSS?', 'CSS is used for styling web pages using selectors and properties.', 0.8),
(261, 'CSS', 'What is a media query in CSS?', 'CSS is a programming language for building websites.', 0),
(262, 'CSS', 'What is z-index in CSS?', 'A property that controls the vertical stacking order of elements.', 1),
(263, 'CSS', 'What is z-index in CSS?', 'It includes rules to define how HTML elements are displayed.', 0.8),
(264, 'CSS', 'What is z-index in CSS?', 'CSS is used for writing server-side scripts.', 0),
(265, 'CSS', 'What is the difference between class and ID selectors in CSS?', 'A class can be used on multiple elements, while an ID is unique to a single element.', 1),
(266, 'CSS', 'What is the difference between class and ID selectors in CSS?', 'A language for adding styles like color and layout to webpages.', 0.8),
(267, 'CSS', 'What is the difference between class and ID selectors in CSS?', 'CSS is a markup language like HTML.', 0),
(268, 'CSS', 'What is pseudo-class in CSS?', 'A keyword added to a selector that defines a special state of an element.', 1),
(269, 'CSS', 'What is pseudo-class in CSS?', 'CSS is used for styling web pages using selectors and properties.', 0.8),
(270, 'CSS', 'What is pseudo-class in CSS?', 'CSS is a programming language for building websites.', 0),
(271, 'CSS', 'What is a pseudo-element in CSS?', 'A keyword that allows styling of specific parts of an element, such as ::before and ::after.', 1),
(272, 'CSS', 'What is a pseudo-element in CSS?', 'It includes rules to define how HTML elements are displayed.', 0.8),
(273, 'CSS', 'What is a pseudo-element in CSS?', 'CSS is used for writing server-side scripts.', 0),
(274, 'CSS', 'What is box model in CSS?', 'The concept of elements having margin, border, padding, and content areas.', 1),
(275, 'CSS', 'What is box model in CSS?', 'A language for adding styles like color and layout to webpages.', 0.8),
(276, 'CSS', 'What is box model in CSS?', 'CSS is a markup language like HTML.', 0),
(277, 'CSS', 'What is the difference between max-width and min-width in CSS?', 'max-width sets the maximum width an element can have, while min-width sets the minimum width.', 1),
(278, 'CSS', 'What is the difference between max-width and min-width in CSS?', 'CSS is used for styling web pages using selectors and properties.', 0.8),
(279, 'CSS', 'What is the difference between max-width and min-width in CSS?', 'CSS is a programming language for building websites.', 0),
(280, 'CSS', 'What is the difference between visibility: hidden and display: none in CSS?', 'visibility: hidden hides the element but keeps its space, while display: none removes it completely.', 1),
(281, 'CSS', 'What is the difference between visibility: hidden and display: none in CSS?', 'It includes rules to define how HTML elements are displayed.', 0.8),
(282, 'CSS', 'What is the difference between visibility: hidden and display: none in CSS?', 'CSS is used for writing server-side scripts.', 0),
(283, 'CSS', 'What is transition in CSS?', 'A property that allows smooth animations between states of an element.', 1),
(284, 'CSS', 'What is transition in CSS?', 'A language for adding styles like color and layout to webpages.', 0.8),
(285, 'CSS', 'What is transition in CSS?', 'CSS is a markup language like HTML.', 0),
(286, 'CSS', 'What is animation in CSS?', 'A method to animate HTML elements using keyframes.', 1),
(287, 'CSS', 'What is animation in CSS?', 'CSS is used for styling web pages using selectors and properties.', 0.8),
(288, 'CSS', 'What is animation in CSS?', 'CSS is a programming language for building websites.', 0),
(289, 'CSS', 'What is hover effect in CSS?', 'A styling change that occurs when a user hovers over an element.', 1),
(290, 'CSS', 'What is hover effect in CSS?', 'It includes rules to define how HTML elements are displayed.', 0.8),
(291, 'CSS', 'What is hover effect in CSS?', 'CSS is used for writing server-side scripts.', 0),
(292, 'CSS', 'What is the difference between relative and absolute units in CSS?', 'Relative units depend on the context (e.g., %, em), while absolute units remain fixed (e.g., px, cm).', 1),
(293, 'CSS', 'What is the difference between relative and absolute units in CSS?', 'A language for adding styles like color and layout to webpages.', 0.8),
(294, 'CSS', 'What is the difference between relative and absolute units in CSS?', 'CSS is a markup language like HTML.', 0),
(295, 'CSS', 'What is the difference between float and flexbox in CSS?', 'Float is an old positioning method, while flexbox is a modern, flexible layout model.', 1),
(296, 'CSS', 'What is the difference between float and flexbox in CSS?', 'CSS is used for styling web pages using selectors and properties.', 0.8),
(297, 'CSS', 'What is the difference between float and flexbox in CSS?', 'CSS is a programming language for building websites.', 0),
(298, 'CSS', 'What is opacity in CSS?', 'A property that defines the transparency level of an element.', 1),
(299, 'CSS', 'What is opacity in CSS?', 'It includes rules to define how HTML elements are displayed.', 0.8),
(300, 'CSS', 'What is opacity in CSS?', 'CSS is used for writing server-side scripts.', 0),
(301, 'JavaScript', 'What is JavaScript?', 'JavaScript is a programming language used for making web pages interactive.', 1),
(302, 'JavaScript', 'What is JavaScript?', 'JavaScript is a language for adding interactivity to web pages.', 0.8),
(303, 'JavaScript', 'What is JavaScript?', 'JavaScript is the same as Java.', 0),
(304, 'JavaScript', 'What is the difference between var, let, and const in JavaScript?', 'var has function scope, let has block scope, and const is immutable.', 1),
(305, 'JavaScript', 'What is the difference between var, let, and const in JavaScript?', 'A scripting language used for dynamic content on websites.', 0.8),
(306, 'JavaScript', 'What is the difference between var, let, and const in JavaScript?', 'JavaScript is only used for backend development.', 0),
(307, 'JavaScript', 'What is an arrow function in JavaScript?', 'A concise function syntax introduced in ES6.', 1),
(308, 'JavaScript', 'What is an arrow function in JavaScript?', 'A high-level programming language used in web development.', 0.8),
(309, 'JavaScript', 'What is an arrow function in JavaScript?', 'JavaScript is a database management language.', 0),
(310, 'JavaScript', 'What is the difference between == and === in JavaScript?', '== compares values, while === compares both value and type.', 1),
(311, 'JavaScript', 'What is the difference between == and === in JavaScript?', 'JavaScript is a language for adding interactivity to web pages.', 0.8),
(312, 'JavaScript', 'What is the difference between == and === in JavaScript?', 'JavaScript is the same as Java.', 0),
(313, 'JavaScript', 'What are JavaScript closures?', 'A function that remembers the variables from its outer scope even after execution.', 1),
(314, 'JavaScript', 'What are JavaScript closures?', 'A scripting language used for dynamic content on websites.', 0.8),
(315, 'JavaScript', 'What are JavaScript closures?', 'JavaScript is only used for backend development.', 0),
(316, 'JavaScript', 'What is the event loop in JavaScript?', 'A mechanism that handles asynchronous operations in JavaScript.', 1),
(317, 'JavaScript', 'What is the event loop in JavaScript?', 'A high-level programming language used in web development.', 0.8),
(318, 'JavaScript', 'What is the event loop in JavaScript?', 'JavaScript is a database management language.', 0),
(319, 'JavaScript', 'What is a promise in JavaScript?', 'An object representing the eventual completion or failure of an asynchronous operation.', 1),
(320, 'JavaScript', 'What is a promise in JavaScript?', 'JavaScript is a language for adding interactivity to web pages.', 0.8),
(321, 'JavaScript', 'What is a promise in JavaScript?', 'JavaScript is the same as Java.', 0),
(322, 'JavaScript', 'What is async/await in JavaScript?', 'A syntax that allows handling asynchronous code in a synchronous-like manner.', 1),
(323, 'JavaScript', 'What is async/await in JavaScript?', 'A scripting language used for dynamic content on websites.', 0.8),
(324, 'JavaScript', 'What is async/await in JavaScript?', 'JavaScript is only used for backend development.', 0),
(325, 'JavaScript', 'What is a callback function in JavaScript?', 'A function passed as an argument to another function and executed later.', 1),
(326, 'JavaScript', 'What is a callback function in JavaScript?', 'A high-level programming language used in web development.', 0.8),
(327, 'JavaScript', 'What is a callback function in JavaScript?', 'JavaScript is a database management language.', 0),
(328, 'JavaScript', 'What is the DOM in JavaScript?', 'The Document Object Model, which represents the structure of a webpage.', 1),
(329, 'JavaScript', 'What is the DOM in JavaScript?', 'JavaScript is a language for adding interactivity to web pages.', 0.8),
(330, 'JavaScript', 'What is the DOM in JavaScript?', 'JavaScript is the same as Java.', 0),
(331, 'JavaScript', 'What is the difference between localStorage, sessionStorage, and cookies?', 'localStorage stores data permanently, sessionStorage for a session, and cookies have expiration dates.', 1),
(332, 'JavaScript', 'What is the difference between localStorage, sessionStorage, and cookies?', 'A scripting language used for dynamic content on websites.', 0.8),
(333, 'JavaScript', 'What is the difference between localStorage, sessionStorage, and cookies?', 'JavaScript is only used for backend development.', 0),
(334, 'JavaScript', 'What is the difference between null and undefined in JavaScript?', 'null represents an assigned empty value, while undefined means a variable has been declared but not assigned.', 1),
(335, 'JavaScript', 'What is the difference between null and undefined in JavaScript?', 'A high-level programming language used in web development.', 0.8),
(336, 'JavaScript', 'What is the difference between null and undefined in JavaScript?', 'JavaScript is a database management language.', 0),
(337, 'JavaScript', 'What is hoisting in JavaScript?', 'A behavior where function and variable declarations are moved to the top of their scope.', 1),
(338, 'JavaScript', 'What is hoisting in JavaScript?', 'JavaScript is a language for adding interactivity to web pages.', 0.8),
(339, 'JavaScript', 'What is hoisting in JavaScript?', 'JavaScript is the same as Java.', 0),
(340, 'JavaScript', 'What is the difference between synchronous and asynchronous JavaScript?', 'Synchronous code runs sequentially, while asynchronous code allows tasks to run independently.', 1),
(341, 'JavaScript', 'What is the difference between synchronous and asynchronous JavaScript?', 'A scripting language used for dynamic content on websites.', 0.8),
(342, 'JavaScript', 'What is the difference between synchronous and asynchronous JavaScript?', 'JavaScript is only used for backend development.', 0),
(343, 'JavaScript', 'What is the spread operator in JavaScript?', 'A syntax that expands iterable elements into individual elements.', 1),
(344, 'JavaScript', 'What is the spread operator in JavaScript?', 'A high-level programming language used in web development.', 0.8),
(345, 'JavaScript', 'What is the spread operator in JavaScript?', 'JavaScript is a database management language.', 0),
(346, 'JavaScript', 'What is destructuring in JavaScript?', 'A feature that allows unpacking values from arrays or objects into separate variables.', 1),
(347, 'JavaScript', 'What is destructuring in JavaScript?', 'JavaScript is a language for adding interactivity to web pages.', 0.8),
(348, 'JavaScript', 'What is destructuring in JavaScript?', 'JavaScript is the same as Java.', 0),
(349, 'JavaScript', 'What is a JavaScript module?', 'A reusable piece of code that can be imported and exported.', 1),
(350, 'JavaScript', 'What is a JavaScript module?', 'A scripting language used for dynamic content on websites.', 0.8),
(351, 'JavaScript', 'What is a JavaScript module?', 'JavaScript is only used for backend development.', 0),
(352, 'JavaScript', 'What is an IIFE in JavaScript?', 'An Immediately Invoked Function Expression, which runs as soon as it\'s defined.', 1),
(353, 'JavaScript', 'What is an IIFE in JavaScript?', 'A high-level programming language used in web development.', 0.8),
(354, 'JavaScript', 'What is an IIFE in JavaScript?', 'JavaScript is a database management language.', 0),
(355, 'JavaScript', 'What is debounce and throttle in JavaScript?', 'Debounce delays function execution, while throttle limits the number of executions over time.', 1),
(356, 'JavaScript', 'What is debounce and throttle in JavaScript?', 'JavaScript is a language for adding interactivity to web pages.', 0.8),
(357, 'JavaScript', 'What is debounce and throttle in JavaScript?', 'JavaScript is the same as Java.', 0),
(358, 'JavaScript', 'What is JSON in JavaScript?', 'JavaScript Object Notation, a format for storing and transporting data.', 1),
(359, 'JavaScript', 'What is JSON in JavaScript?', 'A scripting language used for dynamic content on websites.', 0.8),
(360, 'JavaScript', 'What is JSON in JavaScript?', 'JavaScript is only used for backend development.', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(1, 'akashhiremath608@gmail.com', 'akashhiremath608@gmail.com', '$2b$12$ZoXlFpp7o1XXnxL/z7rVXeBZ555yXGaMzP1MnMgemxD7fDz2uQkM6'),
(2, 'akash', 'akash@gmail.com', '$2b$12$z7tthrPhy7qsXpAhq2rPM.pzovMgUajU31T1nfY.nAgKrdhN5DYPy');

-- --------------------------------------------------------

--
-- Table structure for table `user_scores`
--

CREATE TABLE `user_scores` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `score` float NOT NULL,
  `test_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_videos`
--

CREATE TABLE `user_videos` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `video_path` varchar(255) NOT NULL,
  `upload_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_videos`
--

INSERT INTO `user_videos` (`id`, `user_id`, `video_path`, `upload_time`) VALUES
(2, 1, '1_1741157680.webm', '2025-03-05 06:54:40'),
(3, 1, '1_1741158072.webm', '2025-03-05 07:01:12'),
(4, 1, '1_1741158678.webm', '2025-03-05 07:11:18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `meetings`
--
ALTER TABLE `meetings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `mock_tests`
--
ALTER TABLE `mock_tests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_scores`
--
ALTER TABLE `user_scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_videos`
--
ALTER TABLE `user_videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `meetings`
--
ALTER TABLE `meetings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mock_tests`
--
ALTER TABLE `mock_tests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=361;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_scores`
--
ALTER TABLE `user_scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_videos`
--
ALTER TABLE `user_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `meetings`
--
ALTER TABLE `meetings`
  ADD CONSTRAINT `meetings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mock_tests`
--
ALTER TABLE `mock_tests`
  ADD CONSTRAINT `mock_tests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_scores`
--
ALTER TABLE `user_scores`
  ADD CONSTRAINT `user_scores_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_videos`
--
ALTER TABLE `user_videos`
  ADD CONSTRAINT `user_videos_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
