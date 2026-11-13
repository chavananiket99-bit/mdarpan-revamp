@model Mdarpan.Models.BAL.Login
@{
	Layout = null;
}

<!DOCTYPE html>
<html lang="en-US">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Login - MDarpan 6.0</title>
        <script src="~/assets/js/theme6.0.js"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <script>tailwind.config = { darkMode: 'class' };</script>

        <link rel="icon" type="image/png" href="~/img/Favicon_New.png" />
        <link href="~/css/styles6.0.css" rel="stylesheet" />

        @*
        <link rel="stylesheet" href="https://fontsstorage.blob.core.windows.net/html/css/poppins.css">
        <link rel="stylesheet" type="text/css" href="~/css/freaking-custom.css">
        <link rel="stylesheet" type="text/css" href="~/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="~/css/animate.css">
        <link rel="stylesheet" type="text/css" href="~/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="~/css/owl.theme.default.min.css">
        <link rel="stylesheet" type="text/css" href="~/css/owl.carousel.min.css">
        <link rel="stylesheet" type="text/css" href="~/css/style.css">
        <link href="~/css/sweet-alert.css" rel="stylesheet" />
        <script src="~/js/sweet-alert.min.js"></script>
        <link href="~/css/Eye.css" rel="stylesheet" />
        <link href="~/css/devices.min.css" rel="stylesheet" />
        <link href="~/css/WhatsappPopup.css" rel="stylesheet" />*@

        <script src="~/assets/js/jquery-3.7.1.min.js"></script>

        <script>
            $(function () {
                $("input#UserName").on({
                    change: function () {
                        this.value = this.value.replace(/^\s+|\s+$/g, '');
                    }
                }); $("input#PasswordID").on({
                    change: function () {
                        this.value = this.value.replace(/^\s+|\s+$/g, '');
                    }
                });
            })
        </script>

        <script type="text/javascript">
		    $(document).ready(function () {
			    $('#subbtn').click(function () {
				    $.ajax({
					    type: "POST",
					    url: "@Url.Action("CallAPI", "Login", new { Area = "" })",
					    data: {},
					    success: function (data) {
						    alert(JSON.stringify(data))
					    },
					    error: function (jqXHR, exception) {
						    if (jqXHR.status === 0) {
							    swal('Not connect.\n Verify Network.');
						    }
						    else if (jqXHR.status == 404) {
							    swal('Requested page not found. [404]');
						    }
						    else if (jqXHR.status == 500) {
							    swal('Internal Server Error [500].');
						    }
						    else if (exception === 'parsererror') {
							    swal('Requested JSON parse failed.');
						    }
						    else if (exception === 'timeout') {
							    swal('Time out error.');
						    }
						    else if (exception === 'abort') {
							    swal('Ajax request aborted.');
						    }
						    else {
							    swal('Uncaught Error.\n' + jqXHR.responseText);
						    }
						    StartDone();
					    }
				    })
			    });

			    let passwordInput = document.getElementById('PasswordID'),
			    toggle = document.getElementById('btnToggle'),
			    icon = document.getElementById('eyeIcon');

			    function togglePassword() {
				    if (passwordInput.type === 'password') {
					    passwordInput.type = 'text';
					    icon.classList.add("fa-eye-slash");
					    //toggle.innerHTML = 'hide';
				    }
				    else {
					    passwordInput.type = 'password';
					    icon.classList.remove("fa-eye-slash");
					    //toggle.innerHTML = 'show';
				    }
			    }

			    function checkInput() {
				    //if (passwordInput.value === '') {
				    //toggle.style.display = 'none';
				    //toggle.innerHTML = 'show';
				    //passwordInput.type = 'password';
				    //}
				    //else {
				    //  toggle.style.display = 'block';
				    //}
			    }

			    toggle.addEventListener('click', togglePassword, false);
			    passwordInput.addEventListener('keyup', checkInput, false);
		    });

            function StartValidation() {
                HoldOn.open({
                    theme: 'sk-fading-circle',
                    message: "<h4>Please wait....</h4>"
                });
		    }

            function StartDone() {
                setTimeout(function () {
                    HoldOn.close();
                });
		    }

            $(function () {
                setTimeout(function () { $("#ErrorMessage").fadeOut(1500); }, 5000)
            })
        </script>

        <script src="~/Scripts/aes.js"></script>

        <script>
		    function onSubmitCallback(token) {
			    debugger;
			    $("#CaptchaToken").val(token);
			    $('#FormID').trigger('submit');
		    }

		    //code of SHA256 function
		    function SHA256(s) {
			var chrsz = 8; var hexcase = 0; function safe_add(x, y) { var lsw = (x & 0xFFFF) + (y & 0xFFFF); var msw = (x >> 16) + (y >> 16) + (lsw >> 16); return (msw << 16) | (lsw & 0xFFFF); }
			function S(X, n) { return (X >>> n) | (X << (32 - n)); }
			function R(X, n) { return (X >>> n); }
			function Ch(x, y, z) { return ((x & y) ^ ((~x) & z)); }
			function Maj(x, y, z) { return ((x & y) ^ (x & z) ^ (y & z)); }
			function Sigma0256(x) { return (S(x, 2) ^ S(x, 13) ^ S(x, 22)); }
			function Sigma1256(x) { return (S(x, 6) ^ S(x, 11) ^ S(x, 25)); }
			function Gamma0256(x) { return (S(x, 7) ^ S(x, 18) ^ R(x, 3)); }
			function Gamma1256(x) { return (S(x, 17) ^ S(x, 19) ^ R(x, 10)); }

			function core_sha256(m, l) {
				var K = new Array(0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1, 0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3, 0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174, 0xE49B69C1, 0xEFBE4786, 0xFC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA, 0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147, 0x6CA6351, 0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13, 0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, 0xA2BFE8A1, 0xA81A664B, 0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070, 0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A, 0x5B9CCA4F, 0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208, 0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2); var HASH = new Array(0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19); var W = new Array(64); var a, b, c, d, e, f, g, h, i, j; var T1, T2; m[l >> 5] |= 0x80 << (24 - l % 32); m[((l + 64 >> 9) << 4) + 15] = l; for (var i = 0; i < m.length; i += 16) {
					a = HASH[0]; b = HASH[1]; c = HASH[2]; d = HASH[3]; e = HASH[4]; f = HASH[5]; g = HASH[6]; h = HASH[7]; for (var j = 0; j < 64; j++) { if (j < 16) W[j] = m[j + i]; else W[j] = safe_add(safe_add(safe_add(Gamma1256(W[j - 2]), W[j - 7]), Gamma0256(W[j - 15])), W[j - 16]); T1 = safe_add(safe_add(safe_add(safe_add(h, Sigma1256(e)), Ch(e, f, g)), K[j]), W[j]); T2 = safe_add(Sigma0256(a), Maj(a, b, c)); h = g; g = f; f = e; e = safe_add(d, T1); d = c; c = b; b = a; a = safe_add(T1, T2); }
					HASH[0] = safe_add(a, HASH[0]); HASH[1] = safe_add(b, HASH[1]); HASH[2] = safe_add(c, HASH[2]); HASH[3] = safe_add(d, HASH[3]); HASH[4] = safe_add(e, HASH[4]); HASH[5] = safe_add(f, HASH[5]); HASH[6] = safe_add(g, HASH[6]); HASH[7] = safe_add(h, HASH[7]);
				}
				return HASH;
			}

			function str2binb(str) {
				var bin = Array(); var mask = (1 << chrsz) - 1; for (var i = 0; i < str.length * chrsz; i += chrsz) { bin[i >> 5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i % 32); }
				return bin;
			}

			function Utf8Encode(string) {
				string = string.replace(/\r\n/g, '\n'); var utftext = ''; for (var n = 0; n < string.length; n++) {
					var c = string.charCodeAt(n); if (c < 128) { utftext += String.fromCharCode(c); }
					else if ((c > 127) && (c < 2048)) { utftext += String.fromCharCode((c >> 6) | 192); utftext += String.fromCharCode((c & 63) | 128); }
					else { utftext += String.fromCharCode((c >> 12) | 224); utftext += String.fromCharCode(((c >> 6) & 63) | 128); utftext += String.fromCharCode((c & 63) | 128); }
				}
				return utftext;
			}

			function binb2hex(binarray) {
				var hex_tab = hexcase ? '0123456789ABCDEF' : '0123456789abcdef'; var str = ''; for (var i = 0; i < binarray.length * 4; i++) {
					str += hex_tab.charAt((binarray[i >> 2] >> ((3 - i % 4) * 8 + 4)) & 0xF) +
					hex_tab.charAt((binarray[i >> 2] >> ((3 - i % 4) * 8)) & 0xF);
				}
				return str;
			}
			s = Utf8Encode(s); return binb2hex(core_sha256(str2binb(s), s.length * chrsz));
		}

		// register onclick events for Encrypt button
		$(document).ready(function () {
			//window.setTimeout(function () {
			//$(".alert").fadeTo(500, 0).slideUp(500, function () {
			//$(this).remove();
			//});
			//}, 15000);

			$("#PasswordID").val("");
			$('#FormID').submit(function (event) {//form submit
				debugger;
				//onSubmitCallback(token)
				event.preventDefault();
				var formData = new FormData($(this)[0]);
				if ($(this).valid())
				{
					setTimeout(function () {
						StartValidation('sk-fading-circle');
					}, 0);

					$.ajax({
						type: "POST",
						url: "@Url.Action("GenerateSault", "Login", new { Area = "" })",
						data: {},
						success: function (data) {
							debugger;
							var salt = data;
							//var key = CryptoJS.enc.Utf8.parse('8080808080808080');
							//var iv = CryptoJS.enc.Utf8.parse('8080808080808080');
							//var encryptedPass = CryptoJS.AES.encrypt(CryptoJS.enc.Utf8.parse($("#PasswordID").val()), key,
							//{
							//keySize: 128 / 8,
							//iv: iv,
							//mode: CryptoJS.mode.CBC,
							//padding: CryptoJS.pad.Pkcs7
							//});

							var encryption = salt + $("#PasswordID").val();
							var HashData = SHA256($("#PasswordID").val());
							var hashing = HashData + encryption;
							$("#PasswordID").val(hashing);

							//formData.append("HPassword", encryptedPass);

							formData.append("salt", encryption);
							formData.append("Hashing", hashing);

							//formData.append("Hashing", myVal);

							$.ajax({
								url: "@Url.Action("Index", "Login", new { Area = "" })",
								type: "POST",
								data: formData,
								success: function (data)
								{
									debugger;
									if (data.status == "1") {
										var url = '@Url.Action("DashBoard", "DashBoard", new { Area = "" })';
										window.location.href = url;
										return true;
									}
									else if (data.status == "2") {
										var url = '@Url.Action("Index", "ChangePassword", new { Area = "" })';
										window.location.href = url;
										return true;
									}
									else if (data.status == "6") {
										var url = '@Url.Action("ModalFireworks", "Dashboard", new { Area = "" })';
										window.location.href = url;
										return true;
									}
									else if (data.status == "10") {
										var url = '@Url.Action("Index", "ForgotPassword", new { Area = "" })';
										window.location.href = url;
										return true;
									}
									else if (data.status == "15") {
										setTimeout(function () {
											swal({
												title: "",
												text: data.Message,
												//type: "success",
												showCancelButton: true,
												confirmButtonColor: '#3085d6',
												cancelButtonColor: '#d33',
												confirmButtonText: 'Yes',
												//showConfirmButton: true,
												//showCancelButton: true,
												//confirmButtonText: 'Yes',
												//cancelButtonText: 'No',
												confirmButtonClass: 'btn btn-success',
												cancelButtonClass: 'btn btn-danger',
												//type: 'warning',
												//buttonsStyling: false
											}, function () {
												location.href = "/Login/DealerVerification";
											});
										}, 1000);
										StartDone();
										return true;
									}
									else if (data.status == "16") {
										$("#basicModal .modal-body").html(data.Result);
										$('#basicModal').modal('show');
										StartDone();
										return true;
									}
									else if (data.status == "17")
									{
										//location.href = "/Login/DealerOTPPage";
										location.href = "/Dashboard/Dashboard";
									}
									else if (data.status == "25")
									{
										location.href = "/Login/RedirectToSF";
									}
									else {
										$("#PasswordID").val("");
										$('#lblMessage1').html("");
										$('#lblMessage1').html(data.Message);
										$("#FailedDiv").show();

										//window.setTimeout(function () {
										//$(".alert").fadeTo(500, 0).slideUp(500, function () {
										//$(this).remove();
										//});
										//}, 15000);

										$("html, body").animate({ scrollTop: 0 }, "slow");
										setTimeout(function () { $("#FailedDiv").fadeOut(1500); }, 5000)
										StartDone();
										return false;
									}
								},
								cache: false,
								contentType: false,
								processData: false,
								error: function (jqXHR, exception) {
									if (jqXHR.status === 0) {
										alert('Not connect.\n Verify Network.');
									}
									else if (jqXHR.status == 404) {
										alert('Requested page not found. [404]');
									}
									else if (jqXHR.status == 500) {
										alert('Internal Server Error [500].');
									}
									else if (exception === 'parsererror') {
										alert('Requested JSON parse failed.');
									}
									else if (exception === 'timeout') {
										alert('Time out error.');
									}
									else if (exception === 'abort') {
										alert('Ajax request aborted.');
									}
									else {
										alert('Uncaught Error.\n' + jqXHR.responseText);
									}
									StartDone();
								},
							})
						},
						error: function (jqXHR, exception) {
							if (jqXHR.status === 0) {
								swal('Not connect.\n Verify Network.');
							}
							else if (jqXHR.status == 404) {
								swal('Requested page not found. [404]');
							}
							else if (jqXHR.status == 500) {
								swal('Internal Server Error [500].');
							}
							else if (exception === 'parsererror') {
								swal('Requested JSON parse failed.');
							}
							else if (exception === 'timeout') {
								swal('Time out error.');
							}
							else if (exception === 'abort') {
								swal('Ajax request aborted.');
							}
							else {
								swal('Uncaught Error.\n' + jqXHR.responseText);
							}
							StartDone();
						}
					})
				}
				else {
					return true;
				}
			});
		});
    </script>
</head>

<body class="min-h-screen bg-slate-50 dark:bg-[#0a0714] transition-colors">
    <div class="min-h-screen flex relative overflow-hidden">
        @using (Html.BeginForm("Index", "Login", FormMethod.Post, new { id = "FormID", Area = "", @class= "w-[100%] flex" }))
        {
            @Html.AntiForgeryToken()
            @Html.ValidationSummary(true);

            <!-- Theme toggle (top-right) -->
            <button data-theme-toggle aria-label="Switch theme" class="fixed top-5 right-5 z-30 w-11 h-6 rounded-full bg-slate-200 dark:bg-white/10 border border-slate-300 dark:border-white/10 transition-colors hover:bg-slate-300 dark:hover:bg-white/15">
                <span data-theme-pill class="absolute top-0.5 translate-x-0.5 flex items-center justify-center w-5 h-5 rounded-full shadow-md transition-transform duration-300">
                    <i data-icon-sun data-lucide="sun" class="w-3 h-3 text-white"></i>
                    <i data-icon-moon data-lucide="moon" class="w-3 h-3 text-white hidden"></i>
                </span>
            </button>

            <!-- Ambient background -->
            <div class="absolute inset-0 overflow-hidden pointer-events-none">
                <div class="absolute -top-32 -left-24 w-[520px] h-[520px] bg-[#e31837]/10 dark:bg-[#e31837]/20 rounded-full blur-3xl"></div>
                <div class="absolute top-1/2 -right-32 w-[560px] h-[560px] bg-indigo-500/10 dark:bg-indigo-500/20 rounded-full blur-3xl"></div>
                <div class="absolute -bottom-40 left-1/3 w-[480px] h-[480px] bg-violet-500/10 dark:bg-violet-500/15 rounded-full blur-3xl"></div>
                <div class="absolute top-1/4 left-1/2 w-[380px] h-[380px] bg-emerald-500/10 dark:bg-emerald-500/10 rounded-full blur-3xl"></div>
                <div class="absolute inset-0 opacity-[0.04] dark:opacity-[0.05]" style="background-image: linear-gradient(rgba(15,23,42,.35) 1px, transparent 1px), linear-gradient(90deg, rgba(15,23,42,.35) 1px, transparent 1px); background-size: 32px 32px;"></div>
            </div>

            <!-- Left Side - Branding -->
            <div class="hidden lg:flex lg:w-1/2 relative z-10 items-center justify-center p-12">
                <div class="max-w-lg w-full">
                    <div class="mb-10">
                        <div class="flex items-center gap-3 mb-4">
                            <img src="~/assets/img/mahindra-logo.svg" alt="Mahindra Rise" class="h-8 w-auto object-contain dark:brightness-110" draggable="false" />
                        </div>
                        <div class="h-1 w-24 bg-gradient-to-r from-[#e31837] to-[#ff6b6b] rounded-full"></div>
                    </div>

                    <div class="mb-3 flex items-center gap-2">
                        <div class="w-1 h-4 bg-[#e31837] rounded-full"></div>
                        <span class="text-slate-500 dark:text-white/60 text-[10px] font-semibold tracking-[0.25em] uppercase">Enterprise Platform</span>
                    </div>

                    <h1 class="text-3xl md:text-4xl font-semibold leading-tight text-slate-900 dark:text-white mb-4">
                        Welcome to
                        <span class="bg-gradient-to-r from-[#e31837] to-[#ff6b6b] dark:from-[#ff6b6b] dark:to-amber-300 bg-clip-text text-transparent">MDARPAN 6.0</span>
                    </h1>
                    <p class="text-sm text-slate-600 dark:text-white/60 leading-relaxed mb-8 max-w-md">
                        Your intelligent platform for performance tracking, learning excellence, and seamless collaboration across the Mahindra ecosystem.
                    </p>

                    <div class="grid gap-3">
                        <div class="relative flex items-center gap-4 p-4 bg-white dark:bg-slate-900/60 backdrop-blur-xl rounded-2xl border border-slate-200 dark:border-white/10 shadow-[0_2px_16px_rgba(0,0,0,0.05)] dark:shadow-[0_2px_16px_rgba(0,0,0,0.35)] hover:border-slate-300 dark:hover:border-white/20 transition-all overflow-hidden group">
                            <div class="absolute -top-10 -right-10 w-24 h-24 rounded-full bg-gradient-to-br from-rose-500 to-pink-500 opacity-15 dark:opacity-20 blur-2xl group-hover:opacity-25 dark:group-hover:opacity-30 transition-opacity"></div>
                            <div class="relative w-11 h-11 rounded-xl bg-gradient-to-br from-rose-500 to-pink-500 flex items-center justify-center shadow-lg ring-1 ring-white/10 flex-shrink-0">
                                <i data-lucide="zap" class="w-5 h-5 text-white"></i>
                            </div>
                            <div class="relative">
                                <h4 class="text-sm font-semibold text-slate-900 dark:text-white leading-tight">Real-time Analytics</h4>
                                <p class="text-xs text-slate-500 dark:text-white/50 mt-0.5">Track performance metrics instantly</p>
                            </div>
                        </div>
                        <div class="relative flex items-center gap-4 p-4 bg-white dark:bg-slate-900/60 backdrop-blur-xl rounded-2xl border border-slate-200 dark:border-white/10 shadow-[0_2px_16px_rgba(0,0,0,0.05)] dark:shadow-[0_2px_16px_rgba(0,0,0,0.35)] hover:border-slate-300 dark:hover:border-white/20 transition-all overflow-hidden group">
                            <div class="absolute -top-10 -right-10 w-24 h-24 rounded-full bg-gradient-to-br from-blue-500 to-indigo-500 opacity-15 dark:opacity-20 blur-2xl group-hover:opacity-25 dark:group-hover:opacity-30 transition-opacity"></div>
                            <div class="relative w-11 h-11 rounded-xl bg-gradient-to-br from-blue-500 to-indigo-500 flex items-center justify-center shadow-lg ring-1 ring-white/10 flex-shrink-0">
                                <i data-lucide="shield" class="w-5 h-5 text-white"></i>
                            </div>
                            <div class="relative">
                                <h4 class="text-sm font-semibold text-slate-900 dark:text-white leading-tight">Secure &amp; Compliant</h4>
                                <p class="text-xs text-slate-500 dark:text-white/50 mt-0.5">Enterprise-grade security</p>
                            </div>
                        </div>
                        <div class="relative flex items-center gap-4 p-4 bg-white dark:bg-slate-900/60 backdrop-blur-xl rounded-2xl border border-slate-200 dark:border-white/10 shadow-[0_2px_16px_rgba(0,0,0,0.05)] dark:shadow-[0_2px_16px_rgba(0,0,0,0.35)] hover:border-slate-300 dark:hover:border-white/20 transition-all overflow-hidden group">
                            <div class="absolute -top-10 -right-10 w-24 h-24 rounded-full bg-gradient-to-br from-emerald-500 to-teal-500 opacity-15 dark:opacity-20 blur-2xl group-hover:opacity-25 dark:group-hover:opacity-30 transition-opacity"></div>
                            <div class="relative w-11 h-11 rounded-xl bg-gradient-to-br from-emerald-500 to-teal-500 flex items-center justify-center shadow-lg ring-1 ring-white/10 flex-shrink-0">
                                <i data-lucide="sparkles" class="w-5 h-5 text-white"></i>
                            </div>
                            <div class="relative">
                                <h4 class="text-sm font-semibold text-slate-900 dark:text-white leading-tight">Smart Insights</h4>
                                <p class="text-xs text-slate-500 dark:text-white/50 mt-0.5">AI-powered recommendations</p>
                            </div>
                        </div>
                    </div>

                    <p class="text-xs text-slate-400 dark:text-white/40 mt-10 flex items-center gap-2">
                        <span class="w-1 h-3 bg-slate-300 dark:bg-white/20"></span>
                        © 2026 Mahindra &amp; Mahindra Ltd. All rights reserved.
                    </p>
                </div>
            </div>

            <!-- Right Side - Form -->
            <div class="w-full lg:w-1/2 flex items-center justify-center p-6 md:p-8 relative z-10">
                <div class="w-full max-w-md">
                    <div class="relative bg-white dark:bg-slate-900/60 backdrop-blur-xl rounded-3xl shadow-[0_8px_40px_rgba(0,0,0,0.12)] dark:shadow-[0_8px_40px_rgba(0,0,0,0.5)] border border-slate-200 dark:border-white/10 p-7 md:p-9 overflow-hidden">
                        <div class="absolute -top-20 -right-16 w-56 h-56 bg-[#e31837]/10 dark:bg-[#e31837]/25 rounded-full blur-3xl pointer-events-none"></div>
                        <div class="absolute -bottom-24 -left-16 w-56 h-56 bg-indigo-500/10 dark:bg-indigo-500/20 rounded-full blur-3xl pointer-events-none"></div>

                        <div class="relative">
                            <div class="lg:hidden flex items-center justify-center mb-6">
                                <img src="branding/mahindra-logo.svg" alt="Mahindra Rise" class="h-6 w-auto object-contain dark:brightness-110" draggable="false" />
                            </div>

                            <div class="mb-6 text-center">
                                <div class="inline-flex items-center gap-1.5 mb-3 bg-slate-100 dark:bg-white/5 backdrop-blur-md px-2.5 py-1 rounded-full border border-slate-200 dark:border-white/10">
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 dark:bg-emerald-400 animate-pulse"></span>
                                    <span class="text-slate-600 dark:text-white/70 text-[10px] font-semibold tracking-[0.15em] uppercase">Secure Sign-in</span>
                                </div>
                                <h2 class="text-2xl font-semibold text-slate-900 dark:text-white mb-1">Welcome Back</h2>
                                <p class="text-slate-500 dark:text-white/50 text-sm">Sign in to continue your journey</p>
                            </div>

                            <!-- Method toggle -->
                            <div class="flex gap-1 mb-7 bg-slate-100 dark:bg-white/[0.04] border border-slate-200 dark:border-white/10 p-1 rounded-2xl">
                                <button type="button" id="method-email-btn" class="login-method-btn flex-1 py-2.5 px-4 rounded-xl font-semibold text-sm transition-all duration-300 flex items-center justify-center gap-2">
                                    <i data-lucide="mail" class="w-4 h-4"></i>
                                    Email
                                </button>
                                <button type="button" id="method-mobile-btn" class="login-method-btn flex-1 py-2.5 px-4 rounded-xl font-semibold text-sm transition-all duration-300 flex items-center justify-center gap-2">
                                    <i data-lucide="phone" class="w-4 h-4"></i>
                                    Mobile OTP
                                </button>
                            </div>

                            <form id="login-form" class="space-y-5">
                                <!-- Email method -->
                                <div id="email-panel" class="space-y-4">
                                    <div class="relative">
                                        <input id="email" name="email" type="email" placeholder=" " required
                                               class="peer w-full px-4 py-3 pt-5 pr-11 bg-slate-50 dark:bg-white/[0.04] border border-slate-200 dark:border-white/10 rounded-xl focus:border-[#e31837] focus:bg-white dark:focus:bg-white/[0.06] focus:shadow-[0_0_0_3px_rgba(227,24,55,0.15)] outline-none transition-all text-slate-900 dark:text-white placeholder-transparent" />
                                        <label for="email" class="float-label absolute left-4 pointer-events-none">Email Address</label>
                                        <i data-lucide="mail" class="absolute right-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 dark:text-white/40 pointer-events-none"></i>
                                    </div>

                                    <div class="relative">
                                        <input id="password" name="password" type="password" placeholder=" " required
                                               class="peer w-full px-4 py-3 pt-5 pr-11 bg-slate-50 dark:bg-white/[0.04] border border-slate-200 dark:border-white/10 rounded-xl focus:border-[#e31837] focus:bg-white dark:focus:bg-white/[0.06] focus:shadow-[0_0_0_3px_rgba(227,24,55,0.15)] outline-none transition-all text-slate-900 dark:text-white placeholder-transparent" />
                                        <label for="password" class="float-label absolute left-4 pointer-events-none">Password</label>
                                        <button type="button" id="toggle-password" class="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 dark:text-white/40 hover:text-rose-500 dark:hover:text-rose-300 transition-colors p-1">
                                            <i data-lucide="eye" class="w-4 h-4"></i>
                                        </button>
                                    </div>

                                    <div class="flex items-center justify-between text-xs">
                                        <label class="inline-flex items-center gap-2 text-slate-500 dark:text-white/50 hover:text-slate-700 dark:hover:text-white/80 transition-colors cursor-pointer">
                                            <input type="checkbox" class="w-3.5 h-3.5 rounded bg-slate-100 border-slate-300 dark:bg-white/10 dark:border-white/20 accent-[#e31837]" />
                                            Remember me
                                        </label>
                                        <a href="#" class="font-semibold text-rose-600 dark:text-rose-300 hover:text-rose-700 dark:hover:text-rose-200 transition-colors">Forgot Password?</a>
                                    </div>
                                </div>

                                <!-- Mobile OTP method -->
                                <div id="mobile-panel" class="space-y-4 hidden">
                                    <div class="flex gap-2">
                                        <div class="flex-1 relative">
                                            <input id="mobile" type="tel" inputmode="numeric" maxlength="10" placeholder=" "
                                                   class="peer w-full px-4 py-3 pt-5 pr-11 bg-slate-50 dark:bg-white/[0.04] border border-slate-200 dark:border-white/10 rounded-xl focus:border-[#e31837] focus:bg-white dark:focus:bg-white/[0.06] focus:shadow-[0_0_0_3px_rgba(227,24,55,0.15)] outline-none transition-all text-slate-900 dark:text-white placeholder-transparent disabled:opacity-60" />
                                            <label for="mobile" class="float-label absolute left-4 pointer-events-none">Mobile Number</label>
                                            <i data-lucide="phone" class="absolute right-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 dark:text-white/40 pointer-events-none"></i>
                                        </div>
                                        <button type="button" id="send-otp-btn" disabled
                                                class="px-4 bg-gradient-to-r from-[#e31837] to-[#ff6b6b] hover:brightness-110 disabled:opacity-40 disabled:cursor-not-allowed text-white text-xs font-semibold rounded-xl transition-all shadow-lg shadow-red-500/20 whitespace-nowrap">
                                            Send OTP
                                        </button>
                                    </div>

                                    <div id="otp-block" class="space-y-3 hidden">
                                        <div class="relative">
                                            <input id="otp" type="text" inputmode="numeric" maxlength="6" placeholder=" "
                                                   class="peer w-full px-4 py-4 pt-6 bg-slate-50 dark:bg-white/[0.04] border border-slate-200 dark:border-white/10 rounded-xl focus:border-[#e31837] focus:bg-white dark:focus:bg-white/[0.06] focus:shadow-[0_0_0_3px_rgba(227,24,55,0.15)] outline-none transition-all text-center tracking-[0.5em] text-lg font-semibold text-slate-900 dark:text-white placeholder-transparent" />
                                            <label for="otp" class="float-label-center absolute pointer-events-none">Enter 6-digit OTP</label>
                                        </div>
                                        <div class="flex items-center justify-between text-xs">
                                            <span id="otp-sent-to" class="text-slate-500 dark:text-white/50 font-mono">Sent to +91</span>
                                            <button type="button" id="change-mobile-btn" class="text-rose-600 dark:text-rose-300 hover:text-rose-700 dark:hover:text-rose-200 font-semibold transition-colors">Change</button>
                                        </div>
                                    </div>
                                </div>

                                <button type="submit"
                                        class="w-full bg-gradient-to-r from-[#e31837] via-[#ff4757] to-[#ff6b6b] hover:brightness-110 text-white py-3 rounded-xl font-semibold text-sm transition-all flex items-center justify-center gap-2 shadow-xl shadow-red-500/30 mt-6 ring-1 ring-white/10 active:scale-[0.98]">
                                    Sign In
                                    <i data-lucide="arrow-right" class="w-4 h-4"></i>
                                </button>
                            </form>

                            <div class="flex items-center gap-3 my-6">
                                <div class="flex-1 h-px bg-slate-200 dark:bg-white/10"></div>
                                <span class="text-[10px] font-semibold uppercase tracking-widest text-slate-400 dark:text-white/40">or</span>
                                <div class="flex-1 h-px bg-slate-200 dark:bg-white/10"></div>
                            </div>

                            <div class="flex items-center gap-2 justify-center bg-slate-50 dark:bg-white/[0.03] border border-slate-200 dark:border-white/10 rounded-xl px-3 py-2.5">
                                <i data-lucide="lock" class="w-3.5 h-3.5 text-emerald-500 dark:text-emerald-400"></i>
                                <span class="text-[11px] text-slate-600 dark:text-white/60">Secured with enterprise SSO &amp; MFA</span>
                            </div>

                            <div class="mt-5 text-center">
                                <p class="text-slate-500 dark:text-white/50 text-sm">
                                    Don't have an account?
                                    <a href="#" class="font-semibold bg-gradient-to-r from-[#e31837] to-[#ff6b6b] dark:from-[#ff6b6b] dark:to-amber-300 bg-clip-text text-transparent hover:opacity-80 transition-opacity">Register Now</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--<div class="login_main_wrapper">
                <div id="FailedDiv" class="text-center">
                    <div class="target alert alert-danger fade in" style="padding: 8px; margin-bottom: 0; font-size: 12px;">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close"><i class="fa fa-close"></i></a>
                        <label for="responseMessage" id="lblMessage1"></label>
                    </div>
                    <br>
                    <div id="test1"></div>
                </div>-->

                @*<div id="FailedDiv" class="text-center">
                        <div class="alert alert-danger" role="alert" hidden="hidden">
                            <button type="button" class="close" data-hide="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <strong id="lblMessage1"></strong>
                        </div>
                    </div>*@

                <!--<h3 class="login_heading">Login</h3>-->

                @*<a href="https://api.whatsapp.com/send?phone=9664318884&Message=Hello Aniket">Send Message1</a>*@

                <!--@{
                    string SessionExpire = TempData["Key"] as string;
                    string SuccessMessage = TempData["LoginSuccessMessage"] as string;
                    string FailedMessage = TempData["LoginFailedMessage"] as string;
                    string SuccessMsg = TempData["SuccessMsg"] as string;
                    string AzureADAuthError = TempData["AzureAuthError"] as string;

                    if (SuccessMessage != null)
                    {
                        <div class="alert alert-success" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <strong>Success!</strong> @TempData["LoginSuccessMessage"]
                        </div>
                        <br />
                    }

                    if (FailedMessage != null)
                    {
                        <div class="alert alert-danger" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <strong>Error!</strong> @TempData["LoginFailedMessage"]
                        </div>
                        <br />
                    }

                    if (SessionExpire != null)
                    {
                        <div class="alert alert-danger" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <strong>Error!</strong> @TempData["Key"]
                        </div>
                        <br />
                    }
                    if (AzureADAuthError != null)
                    {
                        <div class="alert alert-danger" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <strong>Error!</strong> @TempData["AzureAuthError"]
                        </div>
                        <br />
                    }
                }

                <script type="text/javascript">
                    $(document).ready(function () {
                        debugger;
                        var gender = $("#gender").val();
                        var gender1 = $("#gender1").val();
                        var gender2 = $("#gender2").val();
                        if (gender == 1) {
                            if ($('#gender').is(':checked')) {
                                $('td:nth-child(2)').hide();
                                $('td:nth-child(3)').hide();
                                $(".header2").hide();
                                $(".header3").hide();
                            }
                        }

                        if (gender1 == 2) {
                            if ($('#gender1').is(':checked')) {
                                $('td:nth-child(1)').hide();
                                $('td:nth-child(3)').hide();
                            }
                        }

                        if (gender2 == 3) {
                            if ($('#gender2').is(':checked')) {
                                $('td:nth-child(1)').hide();
                                $('td:nth-child(2)').hide();
                            }
                        }

                        //$('#btnHide').click(function () {
                        //$('td:nth-child(2)').hide();
                        //});
                    });
                </script>

                <div class="login_inner_box">
                    <div class="login_box">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label for="">Username</label>
                                @Html.TextBoxFor(model => model.UserName, new { Placeholder = "UserName", autocomplete = "off", @class = "form-control", Maxlength = "100" })
                                @Html.ValidationMessageFor(model => model.UserName, "", new { @class = "text-danger" })
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label for="">Password</label>
                                <span class="forgot_pass"><a href="@Url.Action("Index","ForgotPassword",new { Area=""})">Forgot password?</a></span>
                                @Html.PasswordFor(model => model.Password, new { id = "PasswordID", Placeholder = "Password", autocomplete = "off", @class = "form-control", Maxlength = "50" })
                                <button type="button" id="btnToggle" class="toggle"><i id="eyeIcon" class="fa fa-eye"></i></button>

                                @Html.ValidationMessageFor(model => model.Password, "", new { @class = "text-danger" })
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="">
                                <input type="hidden" name="CaptchaToken" id="CaptchaToken" />
                                <input class="btn btn-default login_btn"
                                       type="submit" value="Login" />
                                <div id="demo"></div>-->

                                @*<span class="remember_me_link"><input type="checkbox" id="remember" /><label for="remember" class="rem"></label>Remeber me</span>*@
                            <!--</div>
                        </div>
                        <a id='dwnldLnk' download='Invoice.pdf' style="display:none;" />-->
                        @*<a href="#" onclick="downloadPDF();" title='Invoice.pdf'>Invoice</a>*@
                        <!--<div class="clearfix"></div>
                    </div>
                </div>
                <p class="text-center mobileHide" style="display: flex; gap: 10px;">
                    <a href="@Url.Action("Index","Registration",new { Area=""})" class="ref_link gradient-border">Register Now</a>
                    <a target="_blank" href="@Url.Action("Index","DistLogin",new { Area="distributorLogin"})" class="ref_link gradient-border">Mshoppe Login</a>
                    <a target="_blank" href="@Url.Action("SBMLogin","SBLProfile",new { Area=""})" class="ref_link gradient-border">SBM Login</a>
                </p>
            </div>-->

        }
    </div>
    @*<div id="loader" class="loader_screen">
            <div class="loader_box">
                <img src="~/img/loading.gif" class="img-responsive camera_png" />
            </div>
        </div>*@

    <!-- <div class="back_to_top">
        <i class="fa fa-angle-up"></i>
    </div> -->



    <div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content modal-bg text-center">
                <div class="modal-body">
                </div>
            </div>
        </div>
    </div>

    <div class="footerboard_Dash1" style="display: none;">
        <p class="text">
            <marquee direction="left">
                <span>• Signup is available only on desktop </span>
            </marquee>
        </p>
    </div>

    @*<script src="~/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="~/js/owl.carousel.min.js"></script>*@
    @*<script src="~/js/wow.js"></script>
    <script src="~/js/main.js"></script>*@
    
    <script src="~/Scripts/jquery.validate.min.js"></script>
    <script src="~/Scripts/jquery.validate.unobtrusive.min.js"></script>

    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="~/assets/js/login6.0.js"></script>

</body>
</html>
