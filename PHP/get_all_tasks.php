<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

// Database connection
$host = "localhost"; // Database host
$username = "root"; // Database username
$password = ""; // Database password
$dbname = "task_management"; // Your database name

// Create a connection
$conn = new mysqli($host, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(["success" => false, "message" => "Database connection failed"]));
}

try {
    // Query to get total tasks
    $totalTasksQuery = "SELECT COUNT(*) AS total_tasks FROM tasks";
    $totalTasksResult = $conn->query($totalTasksQuery);
    $totalTasks = $totalTasksResult->fetch_assoc()['total_tasks'];

    // Query to get pending tasks
    $pendingTasksQuery = "SELECT COUNT(*) AS pending_tasks FROM tasks WHERE status = 'pending'";
    $pendingTasksResult = $conn->query($pendingTasksQuery);
    $pendingTasks = $pendingTasksResult->fetch_assoc()['pending_tasks'];

    // Query to get completed tasks
    $completedTasksQuery = "SELECT COUNT(*) AS completed_tasks FROM tasks WHERE status = 'complete'";
    $completedTasksResult = $conn->query($completedTasksQuery);
    $completedTasks = $completedTasksResult->fetch_assoc()['completed_tasks'];

    // Return the results as JSON
    echo json_encode([
        "success" => true,
        "data" => [
            "total_tasks" => $totalTasks,
            "pending_tasks" => $pendingTasks,
            "completed_tasks" => $completedTasks
        ]
    ]);
} catch (Exception $e) {
    echo json_encode([
        "success" => false,
        "message" => "An error occurred while fetching data",
        "error" => $e->getMessage()
    ]);
}

// Close the database connection
$conn->close();
?>
