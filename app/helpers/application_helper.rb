module ApplicationHelper
  def app_name
    'LIMS reports'
  end

  def organization_name
    'Baobab Health Trust'
  end

  def about_organization
    <<EOF
Baobab Health was founded in 2001 by Dr. Thuy Bui and Dr. Gerald P. Douglas as a partnership  and later transformed into a malawian Trust in 2008 to be called Baobab Health Trust (BHT).

BHT is a registered local NGO in Malawi with the Council of Non-governmental Organizations of Malawi (CONGOMA. BHT has dedicated its efforts to revolutionizing the use of technology in developing-world’s health care environments.

Vision

BHT’s Vision is to lead the improvement of health through Information and Communication Technology in the developing world.

Mission

BHT’s Mission is to achieve this by building, deploying and maintaining innovative, robust and sustainable health care information systems suitable for the developing world in collaboration with government and health care workers.

Our Core Business Values

Baobab will always operate within strict legal and ethical boundaries, and encourage everyone that we work with to do the same. We believe strongly in Malawians’ abilities to solve their own challenges and we are committed to hiring, training and developing local staff. We expect handwork from all our staff while nurturing an environment of teamwork and fun. Baobab has a long term commitment to Malawi.

BHT has designed and developed point of care EMRs to augment paper based systems for the Malawi MoH. Local capacity building has been followed in order to have a team of 100% Malawian staff that develop, implement and support the EMR system within the country. In order to encourage knowledge sharing and continuous development of the EMR, BHT uses and follows free and open source software (FOSS) standards. BHT innovation includes technology that operates in an environment characterized by power failures; dusty conditions; health care users that have not used any information and communication technology before. These challenges have translated into BHT using low power consumption devices; green power back up strategies including solar and wind power sources in facilities off the national electricity grid; solid state hard drives; and intuitive touch screen user interfaces that encourage steep learning curves for health care providers.

The work that BHT has been doing for the Ministry of Health has translated into over 1.5 million patients being given unique patient identifiers since 2001. This is in strong realization of that patient records are horizontal across different services and thus the unique identifier enables patient follow up across the continuum of care. Furthermore, 30% of the national patients enrolled into the ART program that are alive and on ART are managed in the EMRs which have been deployed in all the regions of the country. The EMR that has been deployed in the facilities primarily addresses ART and Out-patient-Diagnosis services, initially, but presently other modules are being added on in a phased approach and they include management of chronic diseases; antenatal, maternity and under-5 services; radiology information system; management of lad specimen; and TB-ART management for co-infected patients.
EOF

  end

  def print_content(str)                                                           
    return '' if str.blank?                                                     
    str.html_safe.gsub(/\r\n?/,"<br/>")                                         
  end

  def admin?
    unless User.current_user.blank?
      User.current_user.user_roles.map(&:role).include?('admin') 
    end
  end

end
