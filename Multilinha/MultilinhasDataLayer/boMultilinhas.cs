using MultilinhasObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Runtime.Caching;

namespace MultilinhasDataLayer
{
    public class boMultilinhas
    {
        public const string schema = "DB2PTUSER.";
        System.Runtime.Caching.ObjectCache cache = MemoryCache.Default;
        public DateTime DataOperacao_Fechas(ABUtil.ABCommandArgs AbArgs, string balcao)
        {
            DateTime fechasdt = new DateTime();
            try
            {
                //WriteLog.Log(System.Diagnostics.TraceLevel.Info, PrecarioComissionamentoObjects.LogTypeName.TAT2Request, "DataOperacao_Fechas  - FECHAS", AbArgs.USERNT, AbArgs.SN_HOSTNAME);

                //Vai lêr à tabela

                OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["MASTERDB2LOCAL"].ConnectionString);
                DataSet ds = new DataSet();

                try
                {
                    string query = "SELECT FE_COD_BALCAO, FE_OPER FROM FECHAS WHERE FE_COD_BALCAO = " + balcao;
                    OdbcDataAdapter ad = new OdbcDataAdapter(query, connection); //Tabela sistema FECHAS
                    ad.Fill(ds);
                }
                finally
                {
                    connection.Close();
                }

                //WriteLog.Log(System.Diagnostics.TraceLevel.Verbose, PrecarioComissionamentoObjects.LogTypeName.TAT2Request, "Retun value count: " + ds.Tables[0].Rows.Count, AbArgs.USERNT, AbArgs.SN_HOSTNAME);

                string dtacol = ds.Tables[0].Rows[0][1].ToString(); //coluna 1 da 1a linha

                //retorna data
                DateTime.TryParseExact(dtacol, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, out fechasdt);
                return fechasdt;

            }
            catch (Exception ex)
            {
                //WriteLog.Log(System.Diagnostics.TraceLevel.Error, PrecarioComissionamentoObjects.LogTypeName.TAT2Request, ex, AbArgs.USERNT, AbArgs.SN_HOSTNAME);
                DataTable dt = new DataTable();

                return fechasdt;
            }
        }

        public DataTable GetProdutos(string connection, ABUtil.ABCommandArgs AbArgs)
        {
            try
            {
                DataTable Produtos = cache["Produtos"] as DataTable;

                //WriteLog.Log(System.Diagnostics.TraceLevel.Info, PrecarioComissionamentoObjects.LogTypeName.TAT2Request, "GetProdutos  - TB196 ", AbArgs.USERNT, AbArgs.SN_HOSTNAME);

                //Vai lêr à tabela
                if (Produtos == null)
                {
                    OdbcConnection con = new OdbcConnection(connection);
                    DataSet ds = new DataSet();

                    try
                    {
                        OdbcDataAdapter ad = new OdbcDataAdapter("SELECT CELEMTAB1, GELEM30, NELEMC01, NELEMC02 FROM TB196 where NELEMC01 != ''  order by NELEMC01", con); //Tabela geral TB196
                        ad.Fill(ds);
                    }
                    finally
                    {
                        con.Close();
                    }

                    //WriteLog.Log(System.Diagnostics.TraceLevel.Verbose, PrecarioComissionamentoObjects.LogTypeName.TAT2Request, "Setting cache for [Produtos]", AbArgs.USERNT, AbArgs.SN_HOSTNAME);

                    //Set Cache
                    System.Runtime.Caching.CacheItemPolicy policy = new System.Runtime.Caching.CacheItemPolicy();
                    policy.AbsoluteExpiration = DateTimeOffset.Now.AddDays(1);
                    cache.Set("Produtos", ds.Tables[0], policy);

                    //WriteLog.Log(System.Diagnostics.TraceLevel.Verbose, PrecarioComissionamentoObjects.LogTypeName.TAT2Request, "Retun value count: " + ds.Tables[0].Rows.Count, AbArgs.USERNT, AbArgs.SN_HOSTNAME);

                    return ds.Tables[0];
                }
                //Devolver valor em cache
                else
                {
                    //WriteLog.Log(System.Diagnostics.TraceLevel.Verbose, PrecarioComissionamentoObjects.LogTypeName.TAT2Request, "Cache found for [Produtos] : " + Produtos.Rows.Count, AbArgs.USERNT, AbArgs.SN_HOSTNAME);
                    return Produtos;
                }
            }
            catch (Exception ex)
            {
                //WriteLog.Log(System.Diagnostics.TraceLevel.Error, PrecarioComissionamentoObjects.LogTypeName.TAT2Request, ex, AbArgs.USERNT, AbArgs.SN_HOSTNAME);
                DataTable dt = new DataTable();

                return dt;
            }
        }
    }
}
