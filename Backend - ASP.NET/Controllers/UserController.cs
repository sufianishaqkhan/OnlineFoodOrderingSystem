﻿using OnlineFoodOrderingSystem.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Http;

namespace OnlineFoodOrderingSystem.Controllers
{
    public class UserController : ApiController
    {
        [HttpPost]
        public int LoginUser(string u_email, string u_password)
        {
            using (SqlConnection con = new SqlConnection(AppConnection.GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand("USP_USERS_LOGIN_USER", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("u_email", u_email);
                    cmd.Parameters.AddWithValue("u_pass", u_password);

                    SqlDataReader sdr = cmd.ExecuteReader();
                    if (sdr.Read())
                    {
                        return Convert.ToInt32(sdr["u_id"].ToString());
                    }
                }
            }
            return 0;
        }

        [HttpPost]
        public bool ForgotPassword(string u_email, string u_password)
        {
            using (SqlConnection con = new SqlConnection(AppConnection.GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand("USP_USERS_FORGET_PASSWORD", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("u_email", u_email);
                    cmd.Parameters.AddWithValue("u_pass", u_password);

                    int rowEffected = cmd.ExecuteNonQuery();
                    if (rowEffected > 0)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        [HttpPost]
        public bool PostUser(string u_name, string u_email, string u_password)
        {
            using (SqlConnection con = new SqlConnection(AppConnection.GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand("USP_USERS_INSERT_USERS", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("u_name", u_name);
                    cmd.Parameters.AddWithValue("u_email", u_email);
                    cmd.Parameters.AddWithValue("u_pass", u_password);


                    int rowEffected = cmd.ExecuteNonQuery();
                    if (rowEffected > 0)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        [HttpPost]
        public bool PostOrderDetails(int od_user_id, int od_pid, int od_qty, string od_delivered_loc, decimal od_price)
        {
            using (SqlConnection con = new SqlConnection(AppConnection.GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand("USP_ORDERDETAILS_BUY_PRODUCTS_DETAILS", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("od_user_id", od_user_id);
                    cmd.Parameters.AddWithValue("od_pid", od_pid);
                    cmd.Parameters.AddWithValue("od_qty", od_qty);
                    cmd.Parameters.AddWithValue("od_delivered_loc", od_delivered_loc);
                    cmd.Parameters.AddWithValue("od_price", od_price);


                    int rowEffected = cmd.ExecuteNonQuery();
                    //if (rowEffected > 0)
                    //{
                    //    return true;
                    //}
                }
            }
            using (SqlConnection con = new SqlConnection(AppConnection.GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand("USP_ORDERASSIGNS_PLACE_ORDER", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("oa_u_id", od_user_id);

                    int rowEffected = cmd.ExecuteNonQuery();
                    if (rowEffected > 0)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        [HttpGet]
        public List<OrderAssigns> GetUserOrders(int u_id)
        {
            List<OrderAssigns> orderDetails = new List<OrderAssigns>();
            using (SqlConnection con = new SqlConnection(AppConnection.GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand("USP_USERS_DISP_USER_ORDERS", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("u_id", u_id);


                    SqlDataReader sdr = cmd.ExecuteReader();
                    while (sdr.Read())
                    {
                        OrderAssigns order = new OrderAssigns();
                        order.oa_id = Convert.ToInt32(sdr["oa_id"].ToString());
                        order.u_name = sdr["u_name"].ToString();
                        order.p_name = sdr["p_name"].ToString();
                        order.od_qty = Convert.ToInt32(sdr["od_qty"].ToString());
                        order.od_price = Convert.ToDecimal(sdr["od_price"].ToString());
                        var chk = sdr["oa_db_id"].ToString();
                        if (chk == "")
                        {
                            order.oa_db_id = 0;
                        }
                        else
                            order.oa_db_id = Convert.ToInt32(sdr["oa_db_id"].ToString());
                        order.oa_status = sdr["oa_status"].ToString();
                        orderDetails.Add(order);
                    }
                }
            }

            return orderDetails;
        }
    }
}