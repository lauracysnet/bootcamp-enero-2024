/// 
Class cysnet.clinicaDental.agenda.rules.CheckDatosProcesosCitas Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "Ens.Rule.GeneralBusinessRuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="cysnet.clinicaDental.agenda.bp.ProcesoCitas.Context" production="">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="Comprobar AltasCitas" disabled="false">
<when condition="nombreClase=&quot;AltaCitasRequest&quot;" comment="">
<rule name="validarDatos" disabled="false">
<when condition="objReq.idPaciente!=&quot;&quot;" comment="">
<return>1</return>
</when>
</rule>
</when>
</rule>
<rule name="Comprobar CancelarCita" disabled="false">
<when condition="nombreClase=&quot;CancelarCitaRequest&quot;" comment="">
<assign property="idCita" value="objReq.idCita"></assign>
<assign property="obtenerCita" value="1"></assign>
<rule name="validarDatos" disabled="false">
<when condition="objReq.idCita!=&quot;&quot;" comment="">
<return>1</return>
</when>
</rule>
</when>
</rule>
<rule name="Comprobar ModificarCita" disabled="false">
<when condition="nombreClase=&quot;ModificarCitaRequest&quot;" comment="">
<assign property="idCita" value="objReq.idCita"></assign>
<assign property="obtenerCita" value="1"></assign>
<rule name="validarDatos" disabled="false">
<when condition="objReq.ID!=&quot;&quot;" comment="">
<return>1</return>
</when>
</rule>
</when>
</rule>
<rule name="Comprobar ListarCitas" disabled="false">
<when condition="nombreClase=&quot;ListarCitasRequest&quot;" comment="">
<assign property="idPaciente" value="objReq.idPaciente"></assign>
<assign property="obtenerPaciente" value="1"></assign>
<rule name="validarDatos" disabled="false">
<when condition="objReq.idPaciente!=&quot;&quot;" comment="">
<return>1</return>
</when>
</rule>
</when>
</rule>
<rule name="Comprobar AltaPaciente" disabled="false">
<when condition="nombreClase=&quot;AltaPacienteRequest&quot;" comment="">
<assign property="idCita" value="objReq.idCita"></assign>
<assign property="obtenerAdmision" value="1"></assign>
<assign property="obtenerCita" value="1"></assign>
<assign property="obtenerPaciente" value="1"></assign>
<rule name="validarDatos" disabled="false">
<when condition="objReq.idCita !=&quot;&quot;" comment="">
<return>1</return>
</when>
</rule>
</when>
</rule>
<rule name="Comprobar AdmitirPaciente" disabled="false">
<when condition="nombreClase=&quot;AdmitirPacienteRequest&quot;" comment="">
<assign property="idCita" value="objReq.idCita"></assign>
<assign property="obtenerAdmision" value="1"></assign>
<assign property="obtenerCita" value="1"></assign>
<assign property="obtenerPaciente" value="1"></assign>
<rule name="validarDatos" disabled="false">
<when condition="objReq.idCita !=&quot;&quot;" comment="">
<return>1</return>
</when>
</rule>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
