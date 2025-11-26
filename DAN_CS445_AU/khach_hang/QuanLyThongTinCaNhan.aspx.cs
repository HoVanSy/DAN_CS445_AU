using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace DAN_CS445_AU.khach_hang
{
    public partial class QuanLyThongTinCaNhan : System.Web.UI.Page
    {
        // Chuỗi kết nối database
        string connectionString = GetConnectionString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra đăng nhập
                if (Session["UserID"] == null)
                {
                    // Demo mode - load dữ liệu giả
                    LoadDummyData();
                }
                else
                {
                    LoadUserData();
                }

                // Mặc định hiển thị tab Thông tin cá nhân
                mvContent.ActiveViewIndex = 0;
                UpdateNavigationStyle();
            }
        }

        private static string GetConnectionString()
        {
            try
            {
                var connString = ConfigurationManager.ConnectionStrings["NongSanSachDB"];
                if (connString != null && !string.IsNullOrEmpty(connString.ConnectionString))
                {
                    return connString.ConnectionString;
                }
            }
            catch { }

            // Return null nếu không có connection string - sẽ dùng demo mode
            return null;
        }

        #region Load Data Methods

        private void LoadDummyData()
        {
            // Dữ liệu giả lập
            txtUsername.Text = "khachhang_demo@gmail.com";
            litUserNameSide.Text = "Nguyễn Văn A";
            txtHoTen.Text = "Nguyễn Văn A";
            txtEmail.Text = "nguyenvana@gmail.com";
            txtPhone.Text = "0987654321";
            txtDiaChi.Text = "123 Đường Nông Nghiệp, Quận 1, TP.HCM";
            rbNam.Checked = true;

            // Load dữ liệu đơn hàng giả
            LoadDummyOrders();
            LoadDummyQRHistory();
        }

        private void LoadUserData()
        {
            // Nếu không có connection string, dùng demo mode
            if (string.IsNullOrEmpty(connectionString))
            {
                LoadDummyData();
                return;
            }

            try
            {
                int userId = Convert.ToInt32(Session["UserID"]);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT Email, HoVaTen, SoDienThoai, DiaChi, AnhDaiDien 
                                    FROM Users WHERE user_id = @UserID";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtUsername.Text = reader["Email"].ToString();
                        litUserNameSide.Text = reader["HoVaTen"].ToString();
                        txtHoTen.Text = reader["HoVaTen"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        txtPhone.Text = reader["SoDienThoai"].ToString();
                        txtDiaChi.Text = reader["DiaChi"].ToString();

                        // Giới tính không có trong database, mặc định Nam
                        rbNam.Checked = true;

                        string avatar = reader["AnhDaiDien"].ToString();
                        if (!string.IsNullOrEmpty(avatar))
                        {
                            imgAvatarBig.ImageUrl = avatar;
                            imgAvatarSmall.ImageUrl = avatar;
                        }
                    }
                    reader.Close();
                }

                // Load đơn hàng và lịch sử QR
                LoadOrders(userId);
                LoadQRHistory(userId);
            }
            catch (Exception ex)
            {
                ShowNotification("Lỗi tải dữ liệu: " + ex.Message, false);
            }
        }

        private void LoadDummyOrders()
        {
            // Tạo dữ liệu đơn hàng giả
            DataTable dt = new DataTable();
            dt.Columns.Add("Dh_id", typeof(int));
            dt.Columns.Add("NgayDat", typeof(DateTime));
            dt.Columns.Add("TongTien", typeof(decimal));
            dt.Columns.Add("TrangThai", typeof(string));

            dt.Rows.Add(1, DateTime.Now.AddDays(-5), 450000, "Hoàn thành");
            dt.Rows.Add(2, DateTime.Now.AddDays(-2), 320000, "Đang giao");
            dt.Rows.Add(3, DateTime.Now.AddDays(-1), 580000, "Chờ xử lý");

            rptDonMua.DataSource = dt;
            rptDonMua.DataBind();
            pnlNoDonMua.Visible = (dt.Rows.Count == 0);
        }

        private void LoadOrders(int userId)
        {
            // Nếu không có connection string, dùng demo mode
            if (string.IsNullOrEmpty(connectionString))
            {
                LoadDummyOrders();
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            dh.Dh_id,
                            dh.NgayDat,
                            dh.TrangThai,
                            ISNULL(SUM(ctd.Gia * ctd.SoLuong * (1 - ISNULL(ctd.PhanTramGiamGia, 0) / 100)), 0) as TongTien
                        FROM DonHang dh
                        LEFT JOIN ChiTietDon ctd ON dh.Dh_id = ctd.Dh_id
                        WHERE dh.user_id = @UserID
                        GROUP BY dh.Dh_id, dh.NgayDat, dh.TrangThai
                        ORDER BY dh.NgayDat DESC";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptDonMua.DataSource = dt;
                    rptDonMua.DataBind();
                    pnlNoDonMua.Visible = (dt.Rows.Count == 0);
                }
            }
            catch (Exception ex)
            {
                ShowNotification("Lỗi tải đơn hàng: " + ex.Message, false);
                LoadDummyOrders(); // Fallback to demo data
            }
        }

        private void LoadDummyQRHistory()
        {
            // Tạo dữ liệu lịch sử QR giả
            DataTable dt = new DataTable();
            dt.Columns.Add("sp_id", typeof(int));
            dt.Columns.Add("TenSanPham", typeof(string));
            dt.Columns.Add("NgayQuet", typeof(DateTime));
            dt.Columns.Add("TrangThai", typeof(string));

            dt.Rows.Add(1, "Táo Fuji Nhật Bản", DateTime.Now.AddDays(-3), "Chính hãng");
            dt.Rows.Add(2, "Cam Sành Cao Phong", DateTime.Now.AddDays(-7), "Chính hãng");
            dt.Rows.Add(3, "Dâu Tây Đà Lạt", DateTime.Now.AddDays(-10), "Chính hãng");

            rptLichSuQR.DataSource = dt;
            rptLichSuQR.DataBind();
            pnlNoQRHistory.Visible = (dt.Rows.Count == 0);
        }

        private void LoadQRHistory(int userId)
        {
            // Nếu không có connection string, dùng demo mode
            if (string.IsNullOrEmpty(connectionString))
            {
                LoadDummyQRHistory();
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            nk.nk_id,
                            sp.sp_id,
                            sp.TieuDe as TenSanPham,
                            nk.ThoiGian as NgayQuet,
                            'Đã xem' as TrangThai
                        FROM NhatKyHanhVi nk
                        INNER JOIN SanPham sp ON CAST(nk.DuLieuMoRong as INT) = sp.sp_id
                        WHERE nk.user_id = @UserID 
                            AND nk.LoaiSuKien = N'Xem sản phẩm'
                        ORDER BY nk.ThoiGian DESC";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptLichSuQR.DataSource = dt;
                    rptLichSuQR.DataBind();
                    pnlNoQRHistory.Visible = (dt.Rows.Count == 0);
                }
            }
            catch (Exception ex)
            {
                ShowNotification("Lỗi tải lịch sử: " + ex.Message, false);
                LoadDummyQRHistory(); // Fallback to demo data
            }
        }

        #endregion

        #region Save Methods

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                string hoTen = txtHoTen.Text.Trim();
                string email = txtEmail.Text.Trim();
                string sdt = txtPhone.Text.Trim();
                string diaChi = txtDiaChi.Text.Trim();
                string matKhauMoi = txtNewPass.Text.Trim();

                string avatarFileName = null;

                // Xử lý upload avatar
                if (fileUploadAvatar.HasFile)
                {
                    avatarFileName = ProcessAvatarUpload();
                    if (avatarFileName == null) return; // Có lỗi trong upload
                }

                // Lưu vào database
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    SaveToDatabase(userId, hoTen, email, sdt, diaChi, avatarFileName, matKhauMoi);
                }
                else
                {
                    // Demo mode - chỉ cập nhật giao diện
                    litUserNameSide.Text = hoTen;
                    ShowNotification("Cập nhật thông tin thành công! (Demo mode)", true);
                }

                // Clear password fields
                txtNewPass.Text = "";
                txtConfirmPass.Text = "";
            }
            catch (Exception ex)
            {
                ShowNotification("Có lỗi xảy ra: " + ex.Message, false);
            }
        }

        private string ProcessAvatarUpload()
        {
            try
            {
                string fileExtension = Path.GetExtension(fileUploadAvatar.FileName).ToLower();

                if (fileExtension != ".jpg" && fileExtension != ".png" && fileExtension != ".jpeg")
                {
                    ShowNotification("Chỉ chấp nhận file ảnh .jpg hoặc .png", false);
                    return null;
                }

                // Kiểm tra kích thước file (1MB = 1048576 bytes)
                if (fileUploadAvatar.FileContent.Length > 1048576)
                {
                    ShowNotification("Kích thước file không được vượt quá 1MB", false);
                    return null;
                }

                string fileName = "Avatar_" + DateTime.Now.Ticks + fileExtension;
                string uploadPath = Server.MapPath("~/Uploads/Avatars/");

                if (!Directory.Exists(uploadPath))
                {
                    Directory.CreateDirectory(uploadPath);
                }

                string savePath = uploadPath + fileName;
                fileUploadAvatar.SaveAs(savePath);

                // Cập nhật hiển thị - Đường dẫn tương đối
                string relativePath = "~/Uploads/Avatars/" + fileName;
                imgAvatarBig.ImageUrl = relativePath;
                imgAvatarSmall.ImageUrl = relativePath;

                return relativePath;
            }
            catch (Exception ex)
            {
                ShowNotification("Lỗi upload ảnh: " + ex.Message, false);
                return null;
            }
        }

        private void SaveToDatabase(int userId, string hoTen, string email, string sdt,
                                   string diaChi, string avatarFileName, string matKhauMoi)
        {
            // Nếu không có connection string, chỉ cập nhật giao diện
            if (string.IsNullOrEmpty(connectionString))
            {
                litUserNameSide.Text = hoTen;
                ShowNotification("Cập nhật thông tin thành công! (Demo mode - chưa kết nối database)", true);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE Users SET 
                                    HoVaTen = @HoVaTen,
                                    Email = @Email,
                                    SoDienThoai = @SoDienThoai,
                                    DiaChi = @DiaChi";

                    if (!string.IsNullOrEmpty(avatarFileName))
                    {
                        query += ", AnhDaiDien = @AnhDaiDien";
                    }

                    if (!string.IsNullOrEmpty(matKhauMoi))
                    {
                        query += ", MatKhau = @MatKhau";
                    }

                    query += " WHERE user_id = @UserID";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@HoVaTen", hoTen);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@SoDienThoai", sdt);
                    cmd.Parameters.AddWithValue("@DiaChi", diaChi);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    if (!string.IsNullOrEmpty(avatarFileName))
                    {
                        cmd.Parameters.AddWithValue("@AnhDaiDien", avatarFileName);
                    }

                    if (!string.IsNullOrEmpty(matKhauMoi))
                    {
                        // Hash mật khẩu trước khi lưu
                        string hashedPassword = HashPassword(matKhauMoi);
                        cmd.Parameters.AddWithValue("@MatKhau", hashedPassword);
                    }

                    conn.Open();
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        litUserNameSide.Text = hoTen;
                        Session["UserName"] = hoTen;
                        Session["Email"] = email;
                        ShowNotification("Cập nhật thông tin thành công!", true);
                    }
                    else
                    {
                        ShowNotification("Không thể cập nhật thông tin", false);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowNotification("Lỗi lưu dữ liệu: " + ex.Message, false);
            }
        }

        private string HashPassword(string password)
        {
            // Sử dụng SHA256 để hash mật khẩu
            using (System.Security.Cryptography.SHA256 sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                System.Text.StringBuilder builder = new System.Text.StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        #endregion

        #region Navigation Methods

        protected void lnkThongTinCaNhan_Click(object sender, EventArgs e)
        {
            mvContent.ActiveViewIndex = 0;
            UpdateNavigationStyle();
        }

        protected void lnkDonMua_Click(object sender, EventArgs e)
        {
            mvContent.ActiveViewIndex = 1;
            UpdateNavigationStyle();

            // Reload dữ liệu đơn hàng
            if (Session["UserID"] != null)
            {
                LoadOrders(Convert.ToInt32(Session["UserID"]));
            }
            else
            {
                LoadDummyOrders();
            }
        }

        protected void lnkLichSuQR_Click(object sender, EventArgs e)
        {
            mvContent.ActiveViewIndex = 2;
            UpdateNavigationStyle();

            // Reload lịch sử
            if (Session["UserID"] != null)
            {
                LoadQRHistory(Convert.ToInt32(Session["UserID"]));
            }
            else
            {
                LoadDummyQRHistory();
            }
        }

        protected void lnkDangXuat_Click(object sender, EventArgs e)
        {
            // Xóa session
            Session.Clear();
            Session.Abandon();

            // Redirect về trang đăng nhập hoặc trang chủ
            Response.Redirect("~/DangNhap.aspx");
        }

        private void UpdateNavigationStyle()
        {
            // Reset tất cả các link
            lnkThongTinCaNhan.CssClass = "flex items-center gap-3 px-3 py-2.5 text-gray-600 hover:bg-gray-50 hover:text-gray-900 rounded-lg mb-1 transition-colors";
            lnkDonMua.CssClass = "flex items-center gap-3 px-3 py-2.5 text-gray-600 hover:bg-gray-50 hover:text-gray-900 rounded-lg mb-1 transition-colors";
            lnkLichSuQR.CssClass = "flex items-center gap-3 px-3 py-2.5 text-gray-600 hover:bg-gray-50 hover:text-gray-900 rounded-lg mb-1 transition-colors";

            // Highlight link đang active
            switch (mvContent.ActiveViewIndex)
            {
                case 0:
                    lnkThongTinCaNhan.CssClass = "flex items-center gap-3 px-3 py-2.5 bg-green-50 text-primary font-medium rounded-lg mb-1";
                    break;
                case 1:
                    lnkDonMua.CssClass = "flex items-center gap-3 px-3 py-2.5 bg-green-50 text-primary font-medium rounded-lg mb-1";
                    break;
                case 2:
                    lnkLichSuQR.CssClass = "flex items-center gap-3 px-3 py-2.5 bg-green-50 text-primary font-medium rounded-lg mb-1";
                    break;
            }
        }

        #endregion

        #region Helper Methods

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Reload lại dữ liệu ban đầu
            if (Session["UserID"] != null)
            {
                LoadUserData();
            }
            else
            {
                LoadDummyData();
            }

            // Clear password fields
            txtNewPass.Text = "";
            txtConfirmPass.Text = "";

            ShowNotification("Đã hủy các thay đổi", false);
        }

        protected void btnXemChiTiet_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string maDonHang = btn.CommandArgument;

            // Redirect đến trang chi tiết đơn hàng
            Response.Redirect("~/khach_hang/ChiTietDonHang.aspx?id=" + maDonHang);
        }

        protected string GetStatusClass(string trangThai)
        {
            if (string.IsNullOrEmpty(trangThai)) return "bg-gray-100 text-gray-700";

            switch (trangThai.ToLower().Trim())
            {
                case "hoàn thành":
                case "đã giao":
                    return "bg-green-100 text-green-700";
                case "đang giao":
                    return "bg-blue-100 text-blue-700";
                case "chờ xử lý":
                case "đang xử lý":
                    return "bg-yellow-100 text-yellow-700";
                case "đã hủy":
                    return "bg-red-100 text-red-700";
                default:
                    return "bg-gray-100 text-gray-700";
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

        #endregion
    }
}