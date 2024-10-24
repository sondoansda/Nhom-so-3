# Nhom-so-3
***Todo App - Flutter***

***Todo App*** là một ứng dụng quản lý công việc đơn giản, được phát triển bằng ***Flutter***. Ứng dụng giúp người dùng tạo, chỉnh sửa, xóa và quản lý các công việc cần làm. Mọi thay đổi (thêm, cập nhật, xóa) được đồng bộ hóa với API giả lập thông qua các thao tác CRUD (**Create**, **Read**, **Update**, **Delete**).

***Tính năng chính***

- ***Thêm công việc***: Người dùng có thể thêm công việc mới với tiêu đề và ghi chú tùy chọn.
- ***Hiển thị danh sách công việc***: Công việc được chia thành hai nhóm: ***"Pending Tasks"*** (chưa hoàn thành) và ***"Completed Tasks"*** (đã hoàn thành).
- ***Chỉnh sửa công việc***: Người dùng có thể bấm vào tiêu đề công việc để chỉnh sửa tiêu đề và ghi chú.
- ***Đánh dấu công việc hoàn thành***: Dễ dàng đánh dấu công việc là hoàn thành hoặc chưa hoàn thành.
- ***Xóa công việc***: Xóa bất kỳ công việc nào khỏi danh sách bằng cách bấm vào biểu tượng thùng rác.
- ***Tìm kiếm công việc***: Tìm kiếm công việc dựa trên tiêu đề hoặc ghi chú.

***Cấu trúc thư mục***
``` /lib
  |-- /screens
  |     |-- home_screen.dart            # Màn hình chính hiển thị danh sách công việc
  |     |-- add_task_screen.dart        # Màn hình thêm công việc mới
  |
  |-- /widgets
  |     |-- task_card.dart              # Widget hiển thị từng công việc
  |
  |-- main.dart                         # Điểm vào chính của ứng dụng
```



## Giao diện người dùng
### Màn hình chính
![Giao diện màn hình chính](assets/images/main_screen.png)

### Màn hình thêm công việc
![Màn hình thêm công việc](assets/images/add_task_screen.png)
