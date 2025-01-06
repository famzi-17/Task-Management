
<?php
include 'connect.php';
$data = json_decode(file_get_contents("php://input"));
$task_id = $data->task_id;
$status = $data->status;

$stmt = $conn->prepare("CALL update_task_status(?, ?)");
$stmt->bind_param("is", $task_id, $status);
$stmt->execute();
$result = $stmt->get_result();
$response = $result->fetch_assoc();
echo json_encode($response);
?>
