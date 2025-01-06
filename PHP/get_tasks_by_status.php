
<?php
include 'connect.php';
$status = $_GET['status'];

$stmt = $conn->prepare("CALL fetch_tasks_by_status(?)");
$stmt->bind_param("s", $status);
$stmt->execute();
$result = $stmt->get_result();
$tasks = [];
while ($row = $result->fetch_assoc()) {
    $tasks[] = $row;
}
echo json_encode($tasks);
?>
