<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With');

// Database connection
$host = "localhost";
$username = "root";
$password = "";
$dbname = "task_management";

$conn = new mysqli($host, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Database connection failed"]);
    exit;
}

// Retrieve HTTP method
$method = $_SERVER['REQUEST_METHOD'];

// Process the request based on the HTTP method
switch ($method) {
    case 'GET': // Fetch all tasks or a specific task
        if (isset($_GET['id'])) {
            $id = intval($_GET['id']);
            $sql = "SELECT * FROM tasks WHERE id = $id";
        } else {
            $sql = "SELECT * FROM tasks";
        }

        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            $tasks = [];
            while ($row = $result->fetch_assoc()) {
                $tasks[] = $row;
            }
            echo json_encode(["success" => true, "data" => $tasks]);
        } else {
            echo json_encode(["success" => false, "message" => "No tasks found"]);
        }
        break;

    case 'POST': // Add a new task
        $data = json_decode(file_get_contents("php://input"), true);
        $title = $conn->real_escape_string($data['title']);
        $description = $conn->real_escape_string($data['description']);
        $duration = $conn->real_escape_string($data['duration']);
        $status = $conn->real_escape_string($data['status']);

        $sql = "INSERT INTO tasks (title, description, duration, status) VALUES ('$title', '$description', '$duration', '$status')";
        if ($conn->query($sql)) {
            echo json_encode(["success" => true, "message" => "Task added successfully"]);
        } else {
            echo json_encode(["success" => false, "message" => "Failed to add task"]);
        }
        break;

    case 'PUT': // Update an existing task
        $data = json_decode(file_get_contents("php://input"), true);
        $id = intval($data['id']);
        $title = $conn->real_escape_string($data['title']);
        $description = $conn->real_escape_string($data['description']);
        $duration = $conn->real_escape_string($data['duration']);
        $status = $conn->real_escape_string($data['status']);

        $sql = "UPDATE tasks SET title = '$title', description = '$description', duration = '$duration', status = '$status' WHERE id = $id";
        if ($conn->query($sql)) {
            echo json_encode(["success" => true, "message" => "Task updated successfully"]);
        } else {
            echo json_encode(["success" => false, "message" => "Failed to update task"]);
        }
        break;

    case 'DELETE': // Delete a task
        $data = json_decode(file_get_contents("php://input"), true);
        $id = intval($data['id']);

        $sql = "DELETE FROM tasks WHERE id = $id";
        if ($conn->query($sql)) {
            echo json_encode(["success" => true, "message" => "Task deleted successfully"]);
        } else {
            echo json_encode(["success" => false, "message" => "Failed to delete task"]);
        }
        break;

    default:
        echo json_encode(["success" => false, "message" => "Invalid request method"]);
        break;
}

$conn->close();
?>
