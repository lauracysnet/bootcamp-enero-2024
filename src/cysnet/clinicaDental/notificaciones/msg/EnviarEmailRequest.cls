Class cysnet.clinicaDental.notificaciones.msg.EnviarEmailRequest Extends Ens.Request
{

Property nombre As %String;

Property apellidos As %String;

Property destinatario As %String;

Property asunto As %String(MAXLEN = "");

Property mensaje As %String(MAXLEN = "");

Storage Default
{
<Data name="EnviarEmailRequestDefaultData">
<Subscript>"EnviarEmailRequest"</Subscript>
<Value name="1">
<Value>email</Value>
</Value>
<Value name="2">
<Value>asunto</Value>
</Value>
<Value name="3">
<Value>mensaje</Value>
</Value>
<Value name="4">
<Value>destinatario</Value>
</Value>
<Value name="5">
<Value>nombre</Value>
</Value>
<Value name="6">
<Value>apellido</Value>
</Value>
<Value name="7">
<Value>apellidos</Value>
</Value>
</Data>
<DefaultData>EnviarEmailRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
