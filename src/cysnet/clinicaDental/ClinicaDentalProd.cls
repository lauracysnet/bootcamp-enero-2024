Class cysnet.clinicaDental.ClinicaDentalProd Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="cysnet.clinicaDental.ClinicaDentalProd" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="GestionCitas" Category="" ClassName="cysnet.clinicaDental.agenda.ws.GestionCitas" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Port">1982</Setting>
  </Item>
  <Item Name="GestionPacientes" Category="" ClassName="cysnet.clinicaDental.agenda.ws.GestionPacientes" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Port">1981</Setting>
  </Item>
  <Item Name="AdmisionesSQL" Category="" ClassName="cysnet.clinicaDental.agenda.bo.AdmisionesSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="AltasSQL" Category="" ClassName="cysnet.clinicaDental.agenda.bo.AltasSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="CitasSQL" Category="" ClassName="cysnet.clinicaDental.agenda.bo.CitasSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="PacientesSQL" Category="" ClassName="cysnet.clinicaDental.agenda.bo.PacientesSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="NotificacionesSQL" Category="" ClassName="cysnet.clinicaDental.notificaciones.bo.NotificacionesSQL" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ProcesoPacientes" Category="" ClassName="cysnet.clinicaDental.agenda.bp.ProcesoPacientes" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ProcesoAdmisionesCodigo" Category="" ClassName="cysnet.clinicaDental.agenda.bp.ProcesoAdmisionesCodigo" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="OutFileHL7" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/shared/HL7/salida-HL7/</Setting>
  </Item>
  <Item Name="JavaGateway" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ClassPath">/shared/mysql/mysql-connector-java-5.1.49.jar</Setting>
    <Setting Target="Host" Name="JavaHome">/usr/lib/jvm/temurin-8-jdk-arm64</Setting>
  </Item>
  <Item Name="Ens.Alert" Category="" ClassName="EnsLib.EMail.AlertOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="IncludeDetails">1</Setting>
    <Setting Target="Adapter" Name="Credentials">CuentaGmail</Setting>
    <Setting Target="Adapter" Name="SMTPPort">587</Setting>
    <Setting Target="Adapter" Name="SMTPServer">smtp.gmail.com</Setting>
    <Setting Target="Adapter" Name="SSLConfig">ISC.FeatureTracker.SSL.Config*</Setting>
  </Item>
</Production>
}

}
