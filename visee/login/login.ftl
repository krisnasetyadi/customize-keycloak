<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        <h1 style="font-weight: 700; font-size: 30px"> ${msg("loginAccountTitle")}</h1>
    <#elseif section = "form">
        <div id="kc-form">
          <div id="kc-form-wrapper">
            <#if realm.password>
                <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                    <#if !usernameHidden??>
                        <div class="${properties.kcFormGroupClass!}">
                            <div class="flex-container">
                                <label for="username" class="${properties.kcLabelClass!}" style="font-weight: 600;">
                                    <#if !realm.loginWithEmailAllowed>${msg("username")}
                                    <#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}
                                    <#else>${msg("email")}</#if>
                                </label>
                                <span class='asterisk'>*</span>
                            </div>

                            <input 
                                placeholder="${msg("usernameOrEmailPlaceholder")}" 
                                tabindex="1" 
                                id="username" 
                                class="${properties.kcInputClass!}" 
                                name="username" 
                                value="${(login.username!'')}"  
                                type="text" 
                                autofocus 
                                autocomplete="off"
                                style="border: 1.5px solid #999999; border-radius: 5px;"
                                aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                            />

                            <#if messagesPerField.existsError('username','password')>
                                <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                </span>
                            </#if>

                        </div>
                    </#if>

                    <div class="${properties.kcFormGroupClass!}">
                        <div class="flex-container">
                            <label for="password" class="${properties.kcLabelClass!}" style="font-weight: 600;">${msg("password")}</label>
                            <span class='asterisk'>*</span>
                        </div>

                        <div class="${properties.kcInputGroup!}" style="position: relative;">
                            <input  
                                placeholder="${msg("passwordPlaceholder")}"  
                                tabindex="2" 
                                id="password" 
                                class="${properties.kcInputClass!}" 
                                name="password" 
                                type="password" 
                                autocomplete="off"
                                style="border: 1.5px solid #999999; border-radius: 5px; flex: 1;"
                                aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                            />
                          
                        </div>

                        <#if usernameHidden?? || messagesPerField.existsError('username','password')>
                            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                        </#if>
                    </div>

                    <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                        <div id="kc-form-options">
                            <#if realm.rememberMe && !usernameHidden??>
                                <div class="checkbox">
                                    <label>
                                        <#if login.rememberMe??>
                                            <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                        <#else>
                                            <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                        </#if>
                                    </label>
                                </div>
                            </#if>
                            </div>
                            <div class="${properties.kcFormOptionsWrapperClass!}">
                                <#if realm.resetPasswordAllowed>
                                    <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                                </#if>
                            </div>

                      </div>

                      <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                          <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                          <button 
                            tabindex="4" 
                            class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" 
                            name="login" id="kc-login" type="submit"
                             style="display: flex; justify-content: center; align-items: center; background-color: #1D4ED8"
                             >
                             <span style="flex: 1;">
                                ${msg("doLogIn")}
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
                      </div>
                </form>
            </#if>
            </div>
        </div>
        <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr/>
                <h4>${msg("identity-provider-login-label")}</h4>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <li>
                            <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                    type="button" href="${p.loginUrl}">
                                <#if p.iconClasses?has_content>
                                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                    <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                <#else>
                                    <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                                </#if>
                            </a>
                        </li>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
