<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangKiTaiKhoan.aspx.cs" Inherits="DAN_CS445_AU.khach_vang_lai.DangKiTaiKhoan" %>

<!DOCTYPE html>
<html class="light" lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Đăng ký - MonaFruit</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet"/>
    <style>
        .material-icons-outlined {
            font-weight: normal;
            font-style: normal;
            /* Giảm kích thước icon khoảng 10% (21px -> 19px) */
            font-size: 19px; 
            line-height: 1;
            letter-spacing: normal;
            text-transform: none;
            display: inline-block;
            white-space: nowrap;
            word-wrap: normal;
            direction: ltr;
            -webkit-font-feature-settings: 'liga';
            -webkit-font-smoothing: antialiased;
        }
    </style>

    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#22C55E",
                        "background-light": "#F9FAFB",
                        "background-dark": "#111827",
                    },
                    fontFamily: {
                        display: ["Sora", "sans-serif"],
                    },
                    borderRadius: {
                        DEFAULT: "0.5rem",
                    },
                },
            },
        };
    </script>
</head>
<body class="bg-background-light dark:bg-background-dark font-display text-gray-800 dark:text-gray-200 antialiased text-sm">
    <div class="flex min-h-screen">
        <div class="hidden lg:flex w-1/2 items-center justify-center bg-cover bg-center" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuALx8311d2WwGBSEjRVFk7YRYOB05KKYJl45w2h92a6_SO8QA1_VTpv1TWBjt0u7dPNyOQf0vETewteWQhzbJ6DRLq2i5LDoUu81RPsX4sNuwr-QOAs3y8ium_LDDTragRGrHz1Yt0wenN-VIoJ-Vvq95Cm5iyYOtzlPopaK9QXSo6MJPhyWetQX3UxFVr1Tbv2um3dre0-EzdCjHl9XqpawrEN4VkRWM-W3X-1AxJGN5ufLp8HZ2ZbCaJJo7Xv8u54QaQJcgK1RFuc')">
            <div class="bg-black bg-opacity-50 p-10 rounded-lg text-center">
                <h1 class="text-3xl font-bold text-white mb-3">Tham gia cộng đồng</h1>
                <p class="text-base text-gray-200">Tươi, sạch, và trực tiếp từ nông trại đến bàn ăn của bạn.</p>
            </div>
        </div>

        <div class="w-full lg:w-1/2 flex items-center justify-center p-5 sm:p-8">
            <div class="w-full max-w-sm">
                
                <div class="text-center mb-6">
                    <a class="inline-flex items-center gap-2 text-xl font-bold text-gray-900 dark:text-white" href="#">
                        <span class="material-icons-outlined text-primary" style="font-size: 24px;">eco</span>
                        <span>MonaFruit</span>
                    </a>
                    <h2 class="mt-3 text-2xl font-bold text-gray-900 dark:text-white">Tạo tài khoản</h2>
                    <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">Bắt đầu hành trình ăn uống lành mạnh hơn.</p>
                </div>

                <form id="form1" runat="server" class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300" for="txtHoTen">Họ và tên</label>
                        <div class="mt-1 relative">
                            <span class="material-icons-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">person_outline</span>
                            <asp:TextBox ID="txtHoTen" runat="server" CssClass="pl-9 py-2 w-full rounded-md border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white shadow-sm focus:border-primary focus:ring-primary text-sm" placeholder="Họ và tên"></asp:TextBox>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300" for="txtEmail">Email</label>
                        <div class="mt-1 relative">
                            <span class="material-icons-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">email_outline</span>
                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="pl-9 py-2 w-full rounded-md border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white shadow-sm focus:border-primary focus:ring-primary text-sm" placeholder="Email"></asp:TextBox>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300" for="txtMatKhau">Mật khẩu</label>
                        <div class="mt-1 relative">
                            <span class="material-icons-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">lock_outline</span>
                            <asp:TextBox ID="txtMatKhau" runat="server" TextMode="Password" CssClass="pl-9 py-2 w-full rounded-md border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white shadow-sm focus:border-primary focus:ring-primary text-sm" placeholder="Mật khẩu"></asp:TextBox>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300" for="txtSDT">Số điện thoại</label>
                        <div class="mt-1 relative">
                            <span class="material-icons-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">phone_outline</span>
                            <asp:TextBox ID="txtSDT" runat="server" TextMode="Phone" CssClass="pl-9 py-2 w-full rounded-md border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white shadow-sm focus:border-primary focus:ring-primary text-sm" placeholder="Số điện thoại"></asp:TextBox>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 dark:text-gray-300" for="txtDiaChi">Địa chỉ</label>
                        <div class="mt-1 relative">
                            <span class="material-icons-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">home_outline</span>
                            <asp:TextBox ID="txtDiaChi" runat="server" CssClass="pl-9 py-2 w-full rounded-md border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 text-gray-900 dark:text-white shadow-sm focus:border-primary focus:ring-primary text-sm" placeholder="Địa chỉ"></asp:TextBox>
                        </div>
                    </div>

                    <div>
                        <asp:Button ID="btnDangKy" runat="server" Text="Đăng ký" OnClick="btnDangKy_Click" CssClass="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-semibold text-white bg-primary hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-background-light dark:focus:ring-offset-background-dark focus:ring-primary transition duration-150 ease-in-out cursor-pointer" />
                    </div>
    
                    <asp:Label ID="lblThongBao" runat="server" Text="" CssClass="text-red-500 text-sm text-center block mt-2"></asp:Label>
                </form>
                
                <p class="mt-6 text-center text-sm text-gray-600 dark:text-gray-400">
                    Bạn đã có tài khoản?
                    <a class="font-medium text-primary hover:text-green-500" href="#">
                        Đăng nhập
                    </a>
                </p>
            </div>
        </div>
    </div>
</body>
</html>