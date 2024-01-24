<#import "template.ftl" as layout>
<#import "password-commons.ftl" as passwordCommons>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
          <h1 style="font-weight: 700; font-size: 30px"> ${msg("updatePasswordTitle")}</h1>
    <#elseif section = "form">
        <form id="kc-passwd-update-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                     <div class="flex-container">
                        <label for="password-new" class="${properties.kcLabelClass!}" style="font-weight: 600;">${msg("passwordNew")}</label>
                         <span class='asterisk'>*</span>
                     </div>
                   
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <div class="${properties.kcInputGroup!}">
                        <input 
                            type="password" 
                            id="password-new" 
                            name="password-new" 
                            class="${properties.kcInputClass!}"
                            autofocus 
                            placeholder="${msg("passwordNewPlaceholder")}"
                            autocomplete="new-password"
                            style="border: 1.5px solid #999999; border-radius: 5px;"
                            aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                        />
                    </div>

                    <#if messagesPerField.existsError('password')>
                        <span id="input-error-password" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <div class="flex-container">
                        <label for="password-confirm" class="${properties.kcLabelClass!}"  style="font-weight: 600;">${msg("passwordConfirm")}</label>
                         <span class='asterisk'>*</span>
                    </div>
                   
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <div class="${properties.kcInputGroup!}">
                        <input 
                            type="password" 
                            id="password-confirm" 
                            name="password-confirm"
                            class="${properties.kcInputClass!}"
                            placeholder="${msg("passwordNewConfirm")}"
                            autocomplete="new-password"
                            style="border: 1.5px solid #999999; border-radius: 5px;"
                            aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                        />
                    </div>

                    <#if messagesPerField.existsError('password-confirm')>
                        <span id="input-error-password-confirm" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                        </span>
                    </#if>

                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <@passwordCommons.logoutOtherSessions/>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <#if isAppInitiatedAction??>
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                        <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                    <#else>
                        <button 
                            class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" 
                            type="submit"
                            style="display: flex; justify-content: center; align-items: center; background-color: #1D4ED8"
                            >
                             <span style="flex: 1;">
                                ${msg("doSubmit")}
                            </span>
                            <span style="">
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-arrow-right" width="20" height="20" viewBox="0 0 20 20" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                    <path d="M5 12l14 0" />
                                    <path d="M13 18l6 -6" />
                                    <path d="M13 6l6 6" />
                                </svg>
                            </span>  
                        </button>
                    </#if>
                </div>
            </div>
        </form>
        <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
    </#if>
</@layout.registrationLayout>
