<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// Database connection
$conn = new mysqli("localhost", "root", "", "task_management");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents("php://input"), true);
    $id = $input['id'];

    if ($id) {
        $query = "DELETE FROM tasks WHERE id = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("i", $id);
        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "Task deleted successfully"]);
        } else {
            echo json_encode(["success" => false, "message" => "Failed to delete task"]);
        }
        $stmt->close();
    } else {
        echo json_encode(["success" => false, "message" => "Invalid task ID"]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Invalid request method"]);
}

$conn->close();
?>
