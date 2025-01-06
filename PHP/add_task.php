<?php
// Set headers for API response
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With');

// Include database connection
$host = "localhost"; // Database hostname
$username = "root"; // Database username
$password = ""; // Database password
$dbname = "task_management"; // Database name

$conn = new mysqli($host, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Database connection failed"]);
    exit;
}

// Check if request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve POST data
    $data = json_decode(file_get_contents("php://input"), true);

    $p_user_id = $data['user_id'];
    $p_title = $data['title'];
    $p_description = $data['description'];
    $p_duration = $data['duration'];

    // Call the stored procedure
    $stmt = $conn->prepare("CALL add_task(?, ?, ?, ?)");
    $stmt->bind_param("isss", $p_user_id, $p_title, $p_description, $p_duration);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Task added successfully"]);
    } else {
        echo json_encode(["success" => false, "message" => "Failed to add task"]);
    }

    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Invalid request method"]);
}

$conn->close();
?>
