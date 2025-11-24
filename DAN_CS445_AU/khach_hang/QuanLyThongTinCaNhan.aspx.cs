using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace DAN_CS445_AU.khach_hang
{
    public partial class QuanLyThongTinCaNhan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra xem người dùng đã đăng nhập chưa
                // Giả sử bạn lưu ID người dùng trong Session["UserID"]
                if (Session["UserID"] == null)
                {
                    // Chuyển hướng về trang đăng nhập nếu chưa đăng nhập
                    // Response.Redirect("~/DangNhap.aspx");

                    // Để demo, tôi sẽ load dữ liệu giả định
                    LoadDummyData();
                }
                else
                {
                    LoadUserData();
                }
            }
        }

        private void LoadDummyData()
        {
            // Dữ liệu giả lập để hiển thị khi chưa kết nối Database
            txtUsername.Text = "khachhang_demo";
            litUserNameSide.Text = "Nguyễn Văn A";
            txtHoTen.Text = "Nguyễn Văn A";
            txtEmail.Text = "nguyenvana@gmail.com";
            txtPhone.Text = "0987654321";
            txtDiaChi.Text = "123 Đường Nông Nghiệp, Quận 1, TP.HCM";
            rbNam.Checked = true;
        }

        private void LoadUserData()
        {
            // TODO: Viết code lấy dữ liệu từ SQL Server tại đây
            // Ví dụ:
            // int userId = (int)Session["UserID"];
            // var user = db.Users.Find(userId);
            // txtHoTen.Text = user.HoVaTen;
            // ...
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. Lấy dữ liệu từ form
                string hoTen = txtHoTen.Text.Trim();
                string email = txtEmail.Text.Trim();
                string sdt = txtPhone.Text.Trim();
                string diaChi = txtDiaChi.Text.Trim();
                string matKhauMoi = txtNewPass.Text.Trim();

                string gioiTinh = "Khác";
                if (rbNam.Checked) gioiTinh = "Nam";
                if (rbNu.Checked) gioiTinh = "Nữ";

                // 2. Xử lý Upload Avatar (nếu có chọn file)
                if (fileUploadAvatar.HasFile)
                {
                    string fileExtension = Path.GetExtension(fileUploadAvatar.FileName).ToLower();
                    if (fileExtension == ".jpg" || fileExtension == ".png" || fileExtension == ".jpeg")
                    {
                        // Lưu file vào thư mục /Uploads/Avatars/
                        string fileName = "Avatar_" + DateTime.Now.Ticks + fileExtension;
                        string savePath = Server.MapPath("~/Uploads/Avatars/") + fileName;

                        // Đảm bảo thư mục tồn tại
                        if (!Directory.Exists(Server.MapPath("~/Uploads/Avatars/")))
                        {
                            Directory.CreateDirectory(Server.MapPath("~/Uploads/Avatars/"));
                        }

                        fileUploadAvatar.SaveAs(savePath);

                        // Cập nhật đường dẫn ảnh hiển thị
                        imgAvatarBig.ImageUrl = "~/Uploads/Avatars/" + fileName;
                        imgAvatarSmall.ImageUrl = "~/Uploads/Avatars/" + fileName;

                        // TODO: Lưu đường dẫn 'fileName' vào Database
                    }
                    else
                    {
                        ShowNotification("Chỉ chấp nhận file ảnh .jpg hoặc .png", false);
                        return;
                    }
                }

                // 3. Xử lý đổi mật khẩu
                if (!string.IsNullOrEmpty(matKhauMoi))
                {
                    // TODO: Hash mật khẩu mới và cập nhật vào DB
                    // string hashedPassword = HashPassword(matKhauMoi);
                }

                // 4. Lưu thông tin chung vào Database
                // TODO: Thực hiện câu lệnh SQL UPDATE Users SET ...
                // user.HoVaTen = hoTen;
                // db.SaveChanges();

                // 5. Cập nhật lại giao diện
                litUserNameSide.Text = hoTen; // Cập nhật tên ở sidebar
                ShowNotification("Cập nhật thông tin thành công!", true);
            }
            catch (Exception ex)
            {
                ShowNotification("Có lỗi xảy ra: " + ex.Message, false);
            }
        }

        private void ShowNotification(string message, bool isSuccess)
        {
            lblMessage.Visible = true;
            lblMessage.Text = message;
            if (isSuccess)
            {
                lblMessage.CssClass = "block mb-4 p-4 rounded-lg bg-green-100 text-green-700 border border-green-200";
            }
            else
            {
                lblMessage.CssClass = "block mb-4 p-4 rounded-lg bg-red-100 text-red-700 border border-red-200";
            }
        }
    }
}