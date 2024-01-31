Class cysnet.clinicaDental.notificaciones.bs.InSQLNotificaciones Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.SQL.InboundAdapter";

Method OnProcessInput(pInput As EnsLib.SQL.Snapshot, Output pOutput As %RegisteredObject) As %Status
{
    #dim req as cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionRequest
    #dim rsp As cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionResponse

    set req = ##class(cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionRequest).%New()
    set req.idPaciente = pInput.Get("IdPaciente")
    set req.asunto = pInput.Get("Asunto")
    set req.mensaje = pInput.Get("Mensaje")

    quit ..SendRequestSync("ProcesoNotificaciones",req,.rsp)
}

}
