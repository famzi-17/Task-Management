<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With");

// Database connection
$servername = "localhost";
$username = "root"; // Update with your DB username
$password = "";     // Update with your DB password
$dbname = "task_management";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Database connection failed"]));
}

// Get the request method
$method = $_SERVER['REQUEST_METHOD'];

// Handle API operations
switch ($method) {
    case 'GET':
        // Get all users
        $sql = "SELECT id, username, email, created_at FROM users";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $users = [];
            while ($row = $result->fetch_assoc()) {
                $users[] = $row;
            }
            echo json_encode(["status" => "success", "data" => $users]);
        } else {
            echo json_encode(["status" => "success", "data" => []]);
        }
        break;

    case 'POST':
        // Create a new user
        $data = json_decode(file_get_contents("php://input"), true);
        $username = $data['username'];
        $email = $data['email'];
        $password = $data['password'];
        $createdat = date('Y-m-d H:i:s');

        $sql = "INSERT INTO users (username, email, password, created_at) VALUES ('$username', '$email', '$password', '$createdat')";

        if ($conn->query($sql) === TRUE) {
            echo json_encode(["status" => "success", "message" => "User created successfully"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Error creating user: " . $conn->error]);
        }
        break;

    case 'PUT':
        // Update a user
        $data = json_decode(file_get_contents("php://input"), true);
        $id = $data['id'];
        $username = $data['username'];
        $email = $data['email'];

        $sql = "UPDATE users SET username = '$username', email = '$email' WHERE id = $id";

        if ($conn->query($sql) === TRUE) {
            echo json_encode(["status" => "success", "message" => "User updated successfully"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Error updating user: " . $conn->error]);
        }
        break;

    case 'DELETE':
        // Delete a user
        $data = json_decode(file_get_contents("php://input"), true);
        $id = $data['id'];

        $sql = "DELETE FROM users WHERE id = $id";

        if ($conn->query($sql) === TRUE) {
            echo json_encode(["status" => "success", "message" => "User deleted successfully"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Error deleting user: " . $conn->error]);
        }
        break;

    default:
        echo json_encode(["status" => "error", "message" => "Invalid request method"]);
        break;
}

$conn->close();
?>
