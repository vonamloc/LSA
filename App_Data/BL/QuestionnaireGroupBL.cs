using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LSA
{
    public class QuestionnaireGroupBL
    {
        readonly string DBConnect = ConfigurationManager.ConnectionStrings["LSA_DB"].ConnectionString;
        public int Create(QuestionnaireGroup obj)
        {
            int result = 1;
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            try
            {
                SqlCommand sqlCmd = new SqlCommand("addQuestionnaireGroup", sqlConn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                sqlCmd.Parameters.AddWithValue("@QnsGroupID", obj.QnsGroupID);
                sqlCmd.Parameters.AddWithValue("@Category", obj.Category);
                sqlCmd.Parameters.AddWithValue("@Desc", obj.Desc);
                sqlCmd.Parameters.AddWithValue("@CreateBy", obj.CreateBy);
                sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
                sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

                sqlConn.Open();
                sqlCmd.ExecuteNonQuery();
                result = (int)sqlCmd.Parameters["@rtnValue"].Value;
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "Create", e.Message);
            }
            finally
            {
                sqlConn.Close();
            }

            return result;
        }

        public int Update(QuestionnaireGroup obj)
        {
            int result = 1;
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            try
            {
                SqlCommand sqlCmd = new SqlCommand("updQuestionnaireGroup", sqlConn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                sqlCmd.Parameters.AddWithValue("@QnsGroupID", obj.QnsGroupID);
                sqlCmd.Parameters.AddWithValue("@Category", obj.Category);
                sqlCmd.Parameters.AddWithValue("@Desc", obj.Desc);
                sqlCmd.Parameters.AddWithValue("@AmendBy", obj.AmendBy);
                sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
                sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

                sqlConn.Open();
                sqlCmd.ExecuteNonQuery();
                result = (int)sqlCmd.Parameters["@rtnValue"].Value;
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "Update", e.Message);
            }
            finally
            {
                sqlConn.Close();
            }

            return result;
        }

        public int Delete(int qnsgrpid)
        {
            SqlConnection sqlConn = new SqlConnection(DBConnect);
            int result = 1;
            try
            {
                SqlCommand sqlCmd = new SqlCommand("delQuestionnaireGroup", sqlConn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                sqlCmd.Parameters.AddWithValue("@QnsGroupID", qnsgrpid);
                sqlCmd.Parameters.Add("@rtnValue", SqlDbType.Int);
                sqlCmd.Parameters["@rtnValue"].Direction = ParameterDirection.Output;

                sqlConn.Open();
                sqlCmd.ExecuteNonQuery();
                result = (int)sqlCmd.Parameters["@rtnValue"].Value; sqlConn.Open();
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "Delete", e.Message);
            }
            finally
            {
                sqlConn.Close();
            }

            return result;
        }

        public List<QuestionnaireGroup> Retrieve()
        {
            List<QuestionnaireGroup> result = GetData();
            return result;
        }

        protected List<QuestionnaireGroup> GetData()
        {
            List<QuestionnaireGroup> result = new List<QuestionnaireGroup>();

            try
            {
                SqlConnection sqlConn = new SqlConnection(DBConnect);
                string sqlStmt = "SELECT * FROM QuestionnaireGroup";
                SqlDataAdapter da = new SqlDataAdapter(sqlStmt, sqlConn);

                DataSet ds = new DataSet();
                da.Fill(ds);
                int rec_cnt = ds.Tables[0].Rows.Count;
                for (int i = 0; i < rec_cnt; i++)
                {
                    DataRow row = ds.Tables[0].Rows[i];
                    QuestionnaireGroup obj = ToObj(row);

                    result.Add(obj);
                }
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "GetData", e.Message);
            }

            return result;
        }

        protected QuestionnaireGroup ToObj(DataRow row)
        {
            QuestionnaireGroup obj = null;
            try
            {
                int qnsgrpid = CommonBL.IntegerMapper(row["QnsGroupID"].ToString());
                string category = CommonBL.StringMapper(row["Category"]);
                string desc = CommonBL.StringMapper(row["Desc"]);
                string cBy = CommonBL.StringMapper(row["CreateBy"]);
                DateTime cDate = CommonBL.DateTimeMapper(row["CreateDate"].ToString());
                string aBy = CommonBL.StringMapper(row["AmendBy"]);
                DateTime aDate = CommonBL.DateTimeMapper(row["AmendDate"].ToString());

                obj = new QuestionnaireGroup(qnsgrpid, category, desc, cBy, cDate, aBy, aDate);
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "ToObj", e.Message);
            }

            return obj;
        }
    }
}