using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Linq;

namespace DAN_CS445_AU.admin
{
    // --- 1. MÔ HÌNH DỮ LIỆU SẢN PHẨM ---
    public class Product
    {
        // ... (Giữ nguyên) ...
        public int ProductID { get; set; }
        public string Name { get; set; }
        public string ImageUrl { get; set; }
        public string Category { get; set; }
        public decimal Price { get; set; }
        public int StockQuantity { get; set; }
        public string Status { get; set; }
    }

    public partial class QuanLySanPham : System.Web.UI.Page
    {
        // ... (Dữ liệu mẫu và Page_Load giữ nguyên) ...
        private static List<Product> products;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (products == null)
                {
                    InitializeSampleData();
                }
                BindProductData();
            }
        }

        private void InitializeSampleData()
        {
            // ... (Logic khởi tạo mẫu giữ nguyên) ...
            products = new List<Product>
            {
                new Product { ProductID = 1, Name = "Táo Gala Mỹ", ImageUrl = "https://lh3.googleusercontent.com/aida-public/AB6AXuBGmlXBemqVDwtWNllwkPspdc13lCg6n6hGUhC3UVgThDVm02BOUC5OVmD4ICEMfcad5Cpm9SGmvPgtrETQ7F9PF6KReIQk8c1aBUtT3v7bvV6GOvPB1rZJrhhRaN7uOCjqohU6VkCuoh5iRI9qey_kq-affdyUWG3Lfm4mh49sm373D8bb9NlTAkuIlcpu47A-0B3UIG33yF0lkAU2a-gH_4r4gzm0f0gG1n6M0nyNwgxDguRt4LqQoHeAdhmSHFTlceXcvfSmu9iq", Category = "Trái cây nhập khẩu", Price = 89000, StockQuantity = 120, Status = "Đang bán" },
                new Product { ProductID = 2, Name = "Dâu tây Đà Lạt", ImageUrl = "https://lh3.googleusercontent.com/aida-public/AB6AXuBcc9s4gvFzW-u22rrBjbkotXGiT7IvkSrrFY52V7laMvSi3Eg2vIMEVBPhipr4KW-exzu_-S2oejVBVBPT--fWqik5koIgIk27rBLloitA4lczwpleaBirHjN_DGL949rb1aubuiLhJrO4OpfVddM03411g9WK1XXqAPUyo85dCnIKCpzH8Wvl44PcJz7uDAJj-Ezi7xtGPMKuu9koI6nD-ViJMfvqMNj1-tXrAdrXxYVUoD17hv3Cb0wtV-eKutau5nHG0T3HyB7e", Category = "Trái cây nội địa", Price = 150000, StockQuantity = 85, Status = "Đang bán" },
                new Product { ProductID = 3, Name = "Nho đen không hạt", ImageUrl = "https://lh3.googleusercontent.com/aida-public/AB6AXuBSXUWNqtq93l7NnyfYlPM8quSKHf4z6QyOwsVDA61WkgRiIu8t8ebsc1CMcIAcTpfyQKJ0B8biHRs42MLPgsEuGvHiz4MHaP7sYr2Yp_NHpmd13K2L9AFwoVFqT8tvJSaxGb7mWXTFvUOFBdeYqOYHsO7HfK_0M8VSyQ5zjeKmun_A5gcDKaQnzAf7DuVulwwGY5_UtqldlWQT0O5PKdfUpmOJsVCy3rHgArlTT28Zo62Qn4A8G8pVOw7yM9NalhinP16k_-2og6sA", Category = "Trái cây nhập khẩu", Price = 220000, StockQuantity = 0, Status = "Ẩn" },
                new Product { ProductID = 4, Name = "Dưa hấu Long An", ImageUrl = "https://lh3.googleusercontent.com/aida-public/AB6AXuDlww0CiJCT6wA9aeufnlefYXyK7EonrHRTaHvjZ5kEDNngpwFwYtBrRU04TXcpv9Peu_-9eb339evLiWaZCicNpNM8t9IGxrkfgqJ3EJmtld7qBy2Lb3JcytfTyz1sTyJc8VQlA8JiKlXNBC8V_QGEWBOW0sXJGuVJ_hE1rEtF92UUx3EDs0qF0Sp3aCDm9aPfKLJvcPvYVSeP-aXSnJkGO_Do0Jon4qaussS7V1YlCk26TPN8P9_yfdjUBpIGdFHL6GjAxHc8LtBV", Category = "Trái cây nội địa", Price = 25000, StockQuantity = 250, Status = "Đang bán" },
                new Product { ProductID = 5, Name = "Dứa mật", ImageUrl = "https://lh3.googleusercontent.com/aida-public/AB6AXuCHM-ON-liEOBwWsuBMy3dBrGJTKNJFjSW_lJMeSiajRx219vBYX6P6TA3NI0ze7Neducr2_0G7wefEd6ENVYiGggLoi5UW8s3qFsMRSLQ0ZBD_9SlE6DouFFNJR4WKqfl8NxdOuyKdq8IwulOca5cfk9ohTMW9VboaoJ4-1MiUOJ-Xo4tJyklBi4aCQMHXb_Y3QUBO1bxqAYO-xrHhQDkmPKlsch4gmq3mbLPAiD9g2o5EriMm-MBBry5Dp8ddP_ijZ5nPVaPImrJd", Category = "Trái cây nội địa", Price = 30000, StockQuantity = 90, Status = "Đang bán" }
            };
        }

        // --- 2. HÀM LIÊN KẾT VÀ TÌM KIẾM/LỌC DỮ LIỆU ---
        private void BindProductData()
        {
            IEnumerable<Product> filteredProducts = products;

            // Xử lý Null cho TextBox
            string searchTerm = (txtSearchProduct != null) ? txtSearchProduct.Text.Trim() : string.Empty;

            if (!string.IsNullOrEmpty(searchTerm))
            {
                filteredProducts = filteredProducts.Where(p =>
                    p.Name.ToLower().Contains(searchTerm.ToLower())
                );
            }

            // Xử lý Null cho Repeater (Khắc phục NullReferenceException)
            if (ProductRepeater != null)
            {
                ProductRepeater.DataSource = filteredProducts.ToList();
                ProductRepeater.DataBind();
            }
        }

        // --- 3. XỬ LÝ SỰ KIỆN TỪ CONTROL ---

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProductDetail.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindProductData();
        }

        protected void DeleteProduct(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                if (int.TryParse(e.CommandArgument.ToString(), out int productIDToDelete))
                {
                    products.RemoveAll(p => p.ProductID == productIDToDelete);
                    BindProductData();
                }
            }
        }

        // --- 4. HÀM TIỆN ÍCH DÙNG TRONG MARKUP ASPX (SỬA LỖI CS0103) ---

        // Đã đổi lại sang PUBLIC để khắc phục lỗi biên dịch template ASPX
        public string FormatCurrency(object price)
        {
            if (price is decimal d)
            {
                return $"{d:N0}₫";
            }
            return string.Empty;
        }

        // Đã đổi lại sang PUBLIC để khắc phục lỗi biên dịch template ASPX
        public string GetStatusClass(string status)
        {
            if (status == "Đang bán")
            {
                return "bg-green-100 dark:bg-green-900/50 text-green-800 dark:text-green-300";
            }
            else
            {
                return "bg-gray-100 dark:bg-gray-700 text-gray-800 dark:text-gray-300";
            }
        }
    }
}