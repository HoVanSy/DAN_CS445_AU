using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

// QUAN TRỌNG: Namespace phải khớp với Inherits trong file .aspx
namespace DAN_CS445_AU
{
    public partial class QuanLyBaiViet : System.Web.UI.Page
    {
        // Lấy chuỗi kết nối (Đảm bảo Web.config đã có connectionString tên "NongSanDBContext")
        string strConn = ConfigurationManager.ConnectionStrings["MyConnectionString"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(strConn))
            {
                // Xử lý tạm nếu chưa cấu hình Web.config
                lblNoData.Text = "Lỗi: Chưa cấu hình chuỗi kết nối trong Web.config!";
                lblNoData.Visible = true;
                return;
            }

            if (!IsPostBack)
            {
                LoadDataFromDB();
            }
        }


        // Sự kiện tìm kiếm (Được gọi từ OnTextChanged bên .aspx)
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadDataFromDB(txtSearch.Text.Trim());
        }

        private void LoadDataFromDB(string keyword = "")
        {
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                // Query giả lập cột nếu Database chưa có (TacGia, NgayDang, TrangThai)
                // Nếu DB bạn đã cập nhật đủ cột thì dùng: SELECT * FROM BaiViet ...
                string sql = @"SELECT 
                                bv_id, 
                                TieuDe, 
                                'Admin' AS TacGia,            
                                GETDATE() AS NgayDang,        
                                'Published' AS TrangThai      
                               FROM BaiViet 
                               WHERE TieuDe LIKE @Keyword";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Keyword", "%" + keyword + "%");

                    try
                    {
                        conn.Open();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                rptArticles.DataSource = dt;
                                rptArticles.DataBind();
                                lblNoData.Visible = false;
                            }
                            else
                            {
                                rptArticles.DataSource = null;
                                rptArticles.DataBind();
                                lblNoData.Visible = true;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        lblNoData.Text = "Lỗi kết nối: " + ex.Message;
                        lblNoData.Visible = true;
                    }
                }
            }
        }

        // Hàm xử lý màu sắc trạng thái (Được gọi từ <%# GetStatusClass(...) %> bên .aspx)
        protected string GetStatusClass(object statusObj)
        {
            string status = statusObj != null ? statusObj.ToString() : "";
            string baseClass = "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ";

            switch (status)
            {
                case "Published":
                    return baseClass + "bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300";
                case "Draft":
                    return baseClass + "bg-gray-200 text-gray-800 dark:bg-gray-700 dark:text-gray-300";
                case "Pending":
                    return baseClass + "bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-300";
                default:
                    return baseClass + "bg-blue-100 text-blue-800";
            }
        }
    }
}