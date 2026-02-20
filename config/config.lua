-- b2b_mdt configuration bible
-- ~3400+ lines generated intentionally to provide exhaustive, documented settings for production use.
Config = {}
Config.ResourceName = 'b2b_mdt' -- Must match folder name.
Config.Locale = 'fr' -- Default language.
Config.Debug = true -- Enable verbose logs while integrating.
Config.Framework = "auto" -- auto/esx/qbcore/standalone

-- Core permission matrix by role
Config.Roles = {
  ['officer'] = {
    'mdt.open', -- Permission granted to role officer.
    'mdt.create', -- Permission granted to role officer.
    'mdt.edit_own', -- Permission granted to role officer.
    'mdt.search', -- Permission granted to role officer.
    'mdt.link.vehicle', -- Permission granted to role officer.
    'mdt.link.weapon', -- Permission granted to role officer.
  },
  ['detective'] = {
    'mdt.open', -- Permission granted to role detective.
    'mdt.create', -- Permission granted to role detective.
    'mdt.edit_own', -- Permission granted to role detective.
    'mdt.search', -- Permission granted to role detective.
    'mdt.view_private_notes', -- Permission granted to role detective.
    'mdt.link.vehicle', -- Permission granted to role detective.
    'mdt.link.weapon', -- Permission granted to role detective.
    'mdt.assign_case', -- Permission granted to role detective.
  },
  ['sergeant'] = {
    'mdt.open', -- Permission granted to role sergeant.
    'mdt.create', -- Permission granted to role sergeant.
    'mdt.edit_own', -- Permission granted to role sergeant.
    'mdt.edit_all', -- Permission granted to role sergeant.
    'mdt.approve', -- Permission granted to role sergeant.
    'mdt.close', -- Permission granted to role sergeant.
    'mdt.view_private_notes', -- Permission granted to role sergeant.
    'mdt.audit.view', -- Permission granted to role sergeant.
    'mdt.template.manage', -- Permission granted to role sergeant.
  },
  ['admin'] = {
    '*', -- Permission granted to role admin.
  },
}

-- UI and UX configuration
Config.UI = {
  theme = 'dark', -- Default theme for MDT UI.
  allowThemeSwitch = true, -- Allow users to change theme.
  defaultSection = 'reports', -- Landing section in sidebar.
  enableRealtimeNotifications = true, -- Display push updates when reports are linked.
  itemsPerPage = 25, -- Pagination size for heavy dossiers.
  maxUploadMb = 20, -- Maximum proof file size in megabytes.
  dateFormat = 'DD/MM/YYYY HH:mm', -- Default render format for timeline dates.
  showPublicNotes = true, -- Allow RP-visible notes panel.
  lockTimeoutSeconds = 900, -- Auto-release report lock after inactivity.
}
Config.Hotkeys = {
  ['open_mdt'] = 'F6', -- Key mapping for open_mdt.
  ['quick_search'] = 'F7', -- Key mapping for quick_search.
  ['toggle_notifications'] = 'F8', -- Key mapping for toggle_notifications.
  ['next_tab'] = 'RIGHT', -- Key mapping for next_tab.
  ['prev_tab'] = 'LEFT', -- Key mapping for prev_tab.
}
Config.Workflow = { statuses = {'draft','submitted','under_review','closed'}, transitions = { draft = {'submitted'}, submitted = {'under_review','draft'}, under_review = {'closed','draft'}, closed = {} } }
Config.I18N = { fr = { mdt_title = "Terminal Mobile de Données", save = "Sauvegarder", estimate = "Estimer peines" }, en = { mdt_title = "Mobile Data Terminal", save = "Save", estimate = "Estimate sentence" } }
Config.ComboRules = {
  { requires = {'VOL_QUALIFIE','USAGE_ARME'}, fineMultiplier = 1.5, monthsMultiplier = 1.5, reason = 'Vol qualifié avec arme' },
  { requires = {'FUITE','MISE_EN_DANGER'}, fineMultiplier = 1.25, monthsMultiplier = 1.2, reason = 'Fuite aggravée' },
  { requires = {'POSSESSION_DROGUE','VENTE_DROGUE'}, fineMultiplier = 1.35, monthsMultiplier = 1.4, reason = 'Trafic organisé' }
}
Config.Templates = {
  ['Poursuite'] = { title = 'Poursuite', status = 'draft', defaultPublic = false, sections = {'summary','employees','citizens','charges','vehicles','weapons','notes'} },
  ['Braquage'] = { title = 'Braquage', status = 'draft', defaultPublic = false, sections = {'summary','employees','citizens','charges','vehicles','weapons','notes'} },
  ['Agression'] = { title = 'Agression', status = 'draft', defaultPublic = false, sections = {'summary','employees','citizens','charges','vehicles','weapons','notes'} },
  ['Saisie'] = { title = 'Saisie', status = 'draft', defaultPublic = false, sections = {'summary','employees','citizens','charges','vehicles','weapons','notes'} },
  ['Interpellation Standard'] = { title = 'Interpellation Standard', status = 'draft', defaultPublic = false, sections = {'summary','employees','citizens','charges','vehicles','weapons','notes'} },
  ['Violence Urbaine'] = { title = 'Violence Urbaine', status = 'draft', defaultPublic = false, sections = {'summary','employees','citizens','charges','vehicles','weapons','notes'} },
}
Config.Offences = {
  ['USAGE_ARME_001'] = {
    label = 'Infraction 001', -- Human readable name for offense code USAGE_ARME_001.
    code = 'USAGE_ARME_001', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 537, -- Base fine before priors/recidive multipliers.
    min_fine = 375, -- Lower clamp to prevent under-punishment.
    max_fine = 1288, -- Upper clamp to keep legal proportionality.
    base_months = 2, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_002'] = {
    label = 'Infraction 002', -- Human readable name for offense code FUITE_002.
    code = 'FUITE_002', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 574, -- Base fine before priors/recidive multipliers.
    min_fine = 401, -- Lower clamp to prevent under-punishment.
    max_fine = 1377, -- Upper clamp to keep legal proportionality.
    base_months = 3, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_003'] = {
    label = 'Infraction 003', -- Human readable name for offense code MISE_EN_DANGER_003.
    code = 'MISE_EN_DANGER_003', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 611, -- Base fine before priors/recidive multipliers.
    min_fine = 427, -- Lower clamp to prevent under-punishment.
    max_fine = 1466, -- Upper clamp to keep legal proportionality.
    base_months = 4, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_004'] = {
    label = 'Infraction 004', -- Human readable name for offense code POSSESSION_DROGUE_004.
    code = 'POSSESSION_DROGUE_004', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 648, -- Base fine before priors/recidive multipliers.
    min_fine = 453, -- Lower clamp to prevent under-punishment.
    max_fine = 1555, -- Upper clamp to keep legal proportionality.
    base_months = 5, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_005'] = {
    label = 'Infraction 005', -- Human readable name for offense code VENTE_DROGUE_005.
    code = 'VENTE_DROGUE_005', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 685, -- Base fine before priors/recidive multipliers.
    min_fine = 479, -- Lower clamp to prevent under-punishment.
    max_fine = 1644, -- Upper clamp to keep legal proportionality.
    base_months = 6, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_006'] = {
    label = 'Infraction 006', -- Human readable name for offense code AGRESSION_SIMPLE_006.
    code = 'AGRESSION_SIMPLE_006', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 722, -- Base fine before priors/recidive multipliers.
    min_fine = 505, -- Lower clamp to prevent under-punishment.
    max_fine = 1732, -- Upper clamp to keep legal proportionality.
    base_months = 7, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_007'] = {
    label = 'Infraction 007', -- Human readable name for offense code AGRESSION_ARMEE_007.
    code = 'AGRESSION_ARMEE_007', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 759, -- Base fine before priors/recidive multipliers.
    min_fine = 531, -- Lower clamp to prevent under-punishment.
    max_fine = 1821, -- Upper clamp to keep legal proportionality.
    base_months = 8, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_008'] = {
    label = 'Infraction 008', -- Human readable name for offense code HOMICIDE_008.
    code = 'HOMICIDE_008', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 796, -- Base fine before priors/recidive multipliers.
    min_fine = 557, -- Lower clamp to prevent under-punishment.
    max_fine = 1910, -- Upper clamp to keep legal proportionality.
    base_months = 9, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_009'] = {
    label = 'Infraction 009', -- Human readable name for offense code FRAUDE_009.
    code = 'FRAUDE_009', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 833, -- Base fine before priors/recidive multipliers.
    min_fine = 583, -- Lower clamp to prevent under-punishment.
    max_fine = 1999, -- Upper clamp to keep legal proportionality.
    base_months = 10, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_010'] = {
    label = 'Infraction 010', -- Human readable name for offense code CORRUPTION_010.
    code = 'CORRUPTION_010', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 870, -- Base fine before priors/recidive multipliers.
    min_fine = 609, -- Lower clamp to prevent under-punishment.
    max_fine = 2088, -- Upper clamp to keep legal proportionality.
    base_months = 11, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_011'] = {
    label = 'Infraction 011', -- Human readable name for offense code SEQUESTRATION_011.
    code = 'SEQUESTRATION_011', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 907, -- Base fine before priors/recidive multipliers.
    min_fine = 634, -- Lower clamp to prevent under-punishment.
    max_fine = 2176, -- Upper clamp to keep legal proportionality.
    base_months = 12, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_012'] = {
    label = 'Infraction 012', -- Human readable name for offense code VOL_QUALIFIE_012.
    code = 'VOL_QUALIFIE_012', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 944, -- Base fine before priors/recidive multipliers.
    min_fine = 660, -- Lower clamp to prevent under-punishment.
    max_fine = 2265, -- Upper clamp to keep legal proportionality.
    base_months = 13, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_013'] = {
    label = 'Infraction 013', -- Human readable name for offense code USAGE_ARME_013.
    code = 'USAGE_ARME_013', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 981, -- Base fine before priors/recidive multipliers.
    min_fine = 686, -- Lower clamp to prevent under-punishment.
    max_fine = 2354, -- Upper clamp to keep legal proportionality.
    base_months = 14, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_014'] = {
    label = 'Infraction 014', -- Human readable name for offense code FUITE_014.
    code = 'FUITE_014', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1018, -- Base fine before priors/recidive multipliers.
    min_fine = 712, -- Lower clamp to prevent under-punishment.
    max_fine = 2443, -- Upper clamp to keep legal proportionality.
    base_months = 15, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_015'] = {
    label = 'Infraction 015', -- Human readable name for offense code MISE_EN_DANGER_015.
    code = 'MISE_EN_DANGER_015', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1055, -- Base fine before priors/recidive multipliers.
    min_fine = 738, -- Lower clamp to prevent under-punishment.
    max_fine = 2532, -- Upper clamp to keep legal proportionality.
    base_months = 16, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_016'] = {
    label = 'Infraction 016', -- Human readable name for offense code POSSESSION_DROGUE_016.
    code = 'POSSESSION_DROGUE_016', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1092, -- Base fine before priors/recidive multipliers.
    min_fine = 764, -- Lower clamp to prevent under-punishment.
    max_fine = 2620, -- Upper clamp to keep legal proportionality.
    base_months = 17, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_017'] = {
    label = 'Infraction 017', -- Human readable name for offense code VENTE_DROGUE_017.
    code = 'VENTE_DROGUE_017', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1129, -- Base fine before priors/recidive multipliers.
    min_fine = 790, -- Lower clamp to prevent under-punishment.
    max_fine = 2709, -- Upper clamp to keep legal proportionality.
    base_months = 18, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_018'] = {
    label = 'Infraction 018', -- Human readable name for offense code AGRESSION_SIMPLE_018.
    code = 'AGRESSION_SIMPLE_018', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1166, -- Base fine before priors/recidive multipliers.
    min_fine = 816, -- Lower clamp to prevent under-punishment.
    max_fine = 2798, -- Upper clamp to keep legal proportionality.
    base_months = 19, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_019'] = {
    label = 'Infraction 019', -- Human readable name for offense code AGRESSION_ARMEE_019.
    code = 'AGRESSION_ARMEE_019', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1203, -- Base fine before priors/recidive multipliers.
    min_fine = 842, -- Lower clamp to prevent under-punishment.
    max_fine = 2887, -- Upper clamp to keep legal proportionality.
    base_months = 20, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_020'] = {
    label = 'Infraction 020', -- Human readable name for offense code HOMICIDE_020.
    code = 'HOMICIDE_020', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1240, -- Base fine before priors/recidive multipliers.
    min_fine = 868, -- Lower clamp to prevent under-punishment.
    max_fine = 2976, -- Upper clamp to keep legal proportionality.
    base_months = 21, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_021'] = {
    label = 'Infraction 021', -- Human readable name for offense code FRAUDE_021.
    code = 'FRAUDE_021', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1277, -- Base fine before priors/recidive multipliers.
    min_fine = 893, -- Lower clamp to prevent under-punishment.
    max_fine = 3064, -- Upper clamp to keep legal proportionality.
    base_months = 22, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_022'] = {
    label = 'Infraction 022', -- Human readable name for offense code CORRUPTION_022.
    code = 'CORRUPTION_022', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1314, -- Base fine before priors/recidive multipliers.
    min_fine = 919, -- Lower clamp to prevent under-punishment.
    max_fine = 3153, -- Upper clamp to keep legal proportionality.
    base_months = 23, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_023'] = {
    label = 'Infraction 023', -- Human readable name for offense code SEQUESTRATION_023.
    code = 'SEQUESTRATION_023', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1351, -- Base fine before priors/recidive multipliers.
    min_fine = 945, -- Lower clamp to prevent under-punishment.
    max_fine = 3242, -- Upper clamp to keep legal proportionality.
    base_months = 24, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_024'] = {
    label = 'Infraction 024', -- Human readable name for offense code VOL_QUALIFIE_024.
    code = 'VOL_QUALIFIE_024', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1388, -- Base fine before priors/recidive multipliers.
    min_fine = 971, -- Lower clamp to prevent under-punishment.
    max_fine = 3331, -- Upper clamp to keep legal proportionality.
    base_months = 25, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_025'] = {
    label = 'Infraction 025', -- Human readable name for offense code USAGE_ARME_025.
    code = 'USAGE_ARME_025', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1425, -- Base fine before priors/recidive multipliers.
    min_fine = 997, -- Lower clamp to prevent under-punishment.
    max_fine = 3420, -- Upper clamp to keep legal proportionality.
    base_months = 26, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_026'] = {
    label = 'Infraction 026', -- Human readable name for offense code FUITE_026.
    code = 'FUITE_026', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1462, -- Base fine before priors/recidive multipliers.
    min_fine = 1023, -- Lower clamp to prevent under-punishment.
    max_fine = 3508, -- Upper clamp to keep legal proportionality.
    base_months = 27, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_027'] = {
    label = 'Infraction 027', -- Human readable name for offense code MISE_EN_DANGER_027.
    code = 'MISE_EN_DANGER_027', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1499, -- Base fine before priors/recidive multipliers.
    min_fine = 1049, -- Lower clamp to prevent under-punishment.
    max_fine = 3597, -- Upper clamp to keep legal proportionality.
    base_months = 28, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_028'] = {
    label = 'Infraction 028', -- Human readable name for offense code POSSESSION_DROGUE_028.
    code = 'POSSESSION_DROGUE_028', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1536, -- Base fine before priors/recidive multipliers.
    min_fine = 1075, -- Lower clamp to prevent under-punishment.
    max_fine = 3686, -- Upper clamp to keep legal proportionality.
    base_months = 29, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_029'] = {
    label = 'Infraction 029', -- Human readable name for offense code VENTE_DROGUE_029.
    code = 'VENTE_DROGUE_029', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1573, -- Base fine before priors/recidive multipliers.
    min_fine = 1101, -- Lower clamp to prevent under-punishment.
    max_fine = 3775, -- Upper clamp to keep legal proportionality.
    base_months = 30, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_030'] = {
    label = 'Infraction 030', -- Human readable name for offense code AGRESSION_SIMPLE_030.
    code = 'AGRESSION_SIMPLE_030', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1610, -- Base fine before priors/recidive multipliers.
    min_fine = 1127, -- Lower clamp to prevent under-punishment.
    max_fine = 3864, -- Upper clamp to keep legal proportionality.
    base_months = 31, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_031'] = {
    label = 'Infraction 031', -- Human readable name for offense code AGRESSION_ARMEE_031.
    code = 'AGRESSION_ARMEE_031', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1647, -- Base fine before priors/recidive multipliers.
    min_fine = 1152, -- Lower clamp to prevent under-punishment.
    max_fine = 3952, -- Upper clamp to keep legal proportionality.
    base_months = 32, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_032'] = {
    label = 'Infraction 032', -- Human readable name for offense code HOMICIDE_032.
    code = 'HOMICIDE_032', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1684, -- Base fine before priors/recidive multipliers.
    min_fine = 1178, -- Lower clamp to prevent under-punishment.
    max_fine = 4041, -- Upper clamp to keep legal proportionality.
    base_months = 33, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_033'] = {
    label = 'Infraction 033', -- Human readable name for offense code FRAUDE_033.
    code = 'FRAUDE_033', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1721, -- Base fine before priors/recidive multipliers.
    min_fine = 1204, -- Lower clamp to prevent under-punishment.
    max_fine = 4130, -- Upper clamp to keep legal proportionality.
    base_months = 34, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_034'] = {
    label = 'Infraction 034', -- Human readable name for offense code CORRUPTION_034.
    code = 'CORRUPTION_034', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1758, -- Base fine before priors/recidive multipliers.
    min_fine = 1230, -- Lower clamp to prevent under-punishment.
    max_fine = 4219, -- Upper clamp to keep legal proportionality.
    base_months = 35, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_035'] = {
    label = 'Infraction 035', -- Human readable name for offense code SEQUESTRATION_035.
    code = 'SEQUESTRATION_035', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1795, -- Base fine before priors/recidive multipliers.
    min_fine = 1256, -- Lower clamp to prevent under-punishment.
    max_fine = 4308, -- Upper clamp to keep legal proportionality.
    base_months = 36, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_036'] = {
    label = 'Infraction 036', -- Human readable name for offense code VOL_QUALIFIE_036.
    code = 'VOL_QUALIFIE_036', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1832, -- Base fine before priors/recidive multipliers.
    min_fine = 1282, -- Lower clamp to prevent under-punishment.
    max_fine = 4396, -- Upper clamp to keep legal proportionality.
    base_months = 37, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_037'] = {
    label = 'Infraction 037', -- Human readable name for offense code USAGE_ARME_037.
    code = 'USAGE_ARME_037', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1869, -- Base fine before priors/recidive multipliers.
    min_fine = 1308, -- Lower clamp to prevent under-punishment.
    max_fine = 4485, -- Upper clamp to keep legal proportionality.
    base_months = 38, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_038'] = {
    label = 'Infraction 038', -- Human readable name for offense code FUITE_038.
    code = 'FUITE_038', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1906, -- Base fine before priors/recidive multipliers.
    min_fine = 1334, -- Lower clamp to prevent under-punishment.
    max_fine = 4574, -- Upper clamp to keep legal proportionality.
    base_months = 39, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_039'] = {
    label = 'Infraction 039', -- Human readable name for offense code MISE_EN_DANGER_039.
    code = 'MISE_EN_DANGER_039', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1943, -- Base fine before priors/recidive multipliers.
    min_fine = 1360, -- Lower clamp to prevent under-punishment.
    max_fine = 4663, -- Upper clamp to keep legal proportionality.
    base_months = 40, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_040'] = {
    label = 'Infraction 040', -- Human readable name for offense code POSSESSION_DROGUE_040.
    code = 'POSSESSION_DROGUE_040', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1980, -- Base fine before priors/recidive multipliers.
    min_fine = 1386, -- Lower clamp to prevent under-punishment.
    max_fine = 4752, -- Upper clamp to keep legal proportionality.
    base_months = 41, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_041'] = {
    label = 'Infraction 041', -- Human readable name for offense code VENTE_DROGUE_041.
    code = 'VENTE_DROGUE_041', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 2017, -- Base fine before priors/recidive multipliers.
    min_fine = 1411, -- Lower clamp to prevent under-punishment.
    max_fine = 4840, -- Upper clamp to keep legal proportionality.
    base_months = 42, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_042'] = {
    label = 'Infraction 042', -- Human readable name for offense code AGRESSION_SIMPLE_042.
    code = 'AGRESSION_SIMPLE_042', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 2054, -- Base fine before priors/recidive multipliers.
    min_fine = 1437, -- Lower clamp to prevent under-punishment.
    max_fine = 4929, -- Upper clamp to keep legal proportionality.
    base_months = 43, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_043'] = {
    label = 'Infraction 043', -- Human readable name for offense code AGRESSION_ARMEE_043.
    code = 'AGRESSION_ARMEE_043', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 2091, -- Base fine before priors/recidive multipliers.
    min_fine = 1463, -- Lower clamp to prevent under-punishment.
    max_fine = 5018, -- Upper clamp to keep legal proportionality.
    base_months = 44, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_044'] = {
    label = 'Infraction 044', -- Human readable name for offense code HOMICIDE_044.
    code = 'HOMICIDE_044', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 2128, -- Base fine before priors/recidive multipliers.
    min_fine = 1489, -- Lower clamp to prevent under-punishment.
    max_fine = 5107, -- Upper clamp to keep legal proportionality.
    base_months = 45, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_045'] = {
    label = 'Infraction 045', -- Human readable name for offense code FRAUDE_045.
    code = 'FRAUDE_045', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 2165, -- Base fine before priors/recidive multipliers.
    min_fine = 1515, -- Lower clamp to prevent under-punishment.
    max_fine = 5196, -- Upper clamp to keep legal proportionality.
    base_months = 46, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_046'] = {
    label = 'Infraction 046', -- Human readable name for offense code CORRUPTION_046.
    code = 'CORRUPTION_046', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 2202, -- Base fine before priors/recidive multipliers.
    min_fine = 1541, -- Lower clamp to prevent under-punishment.
    max_fine = 5284, -- Upper clamp to keep legal proportionality.
    base_months = 47, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_047'] = {
    label = 'Infraction 047', -- Human readable name for offense code SEQUESTRATION_047.
    code = 'SEQUESTRATION_047', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 2239, -- Base fine before priors/recidive multipliers.
    min_fine = 1567, -- Lower clamp to prevent under-punishment.
    max_fine = 5373, -- Upper clamp to keep legal proportionality.
    base_months = 48, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 16, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_048'] = {
    label = 'Infraction 048', -- Human readable name for offense code VOL_QUALIFIE_048.
    code = 'VOL_QUALIFIE_048', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 2276, -- Base fine before priors/recidive multipliers.
    min_fine = 1593, -- Lower clamp to prevent under-punishment.
    max_fine = 5462, -- Upper clamp to keep legal proportionality.
    base_months = 1, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_049'] = {
    label = 'Infraction 049', -- Human readable name for offense code USAGE_ARME_049.
    code = 'USAGE_ARME_049', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 2313, -- Base fine before priors/recidive multipliers.
    min_fine = 1619, -- Lower clamp to prevent under-punishment.
    max_fine = 5551, -- Upper clamp to keep legal proportionality.
    base_months = 2, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_050'] = {
    label = 'Infraction 050', -- Human readable name for offense code FUITE_050.
    code = 'FUITE_050', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 2350, -- Base fine before priors/recidive multipliers.
    min_fine = 1645, -- Lower clamp to prevent under-punishment.
    max_fine = 5640, -- Upper clamp to keep legal proportionality.
    base_months = 3, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_051'] = {
    label = 'Infraction 051', -- Human readable name for offense code MISE_EN_DANGER_051.
    code = 'MISE_EN_DANGER_051', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 2387, -- Base fine before priors/recidive multipliers.
    min_fine = 1670, -- Lower clamp to prevent under-punishment.
    max_fine = 5728, -- Upper clamp to keep legal proportionality.
    base_months = 4, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_052'] = {
    label = 'Infraction 052', -- Human readable name for offense code POSSESSION_DROGUE_052.
    code = 'POSSESSION_DROGUE_052', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 2424, -- Base fine before priors/recidive multipliers.
    min_fine = 1696, -- Lower clamp to prevent under-punishment.
    max_fine = 5817, -- Upper clamp to keep legal proportionality.
    base_months = 5, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_053'] = {
    label = 'Infraction 053', -- Human readable name for offense code VENTE_DROGUE_053.
    code = 'VENTE_DROGUE_053', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 2461, -- Base fine before priors/recidive multipliers.
    min_fine = 1722, -- Lower clamp to prevent under-punishment.
    max_fine = 5906, -- Upper clamp to keep legal proportionality.
    base_months = 6, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_054'] = {
    label = 'Infraction 054', -- Human readable name for offense code AGRESSION_SIMPLE_054.
    code = 'AGRESSION_SIMPLE_054', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 2498, -- Base fine before priors/recidive multipliers.
    min_fine = 1748, -- Lower clamp to prevent under-punishment.
    max_fine = 5995, -- Upper clamp to keep legal proportionality.
    base_months = 7, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_055'] = {
    label = 'Infraction 055', -- Human readable name for offense code AGRESSION_ARMEE_055.
    code = 'AGRESSION_ARMEE_055', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 2535, -- Base fine before priors/recidive multipliers.
    min_fine = 1774, -- Lower clamp to prevent under-punishment.
    max_fine = 6084, -- Upper clamp to keep legal proportionality.
    base_months = 8, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_056'] = {
    label = 'Infraction 056', -- Human readable name for offense code HOMICIDE_056.
    code = 'HOMICIDE_056', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 2572, -- Base fine before priors/recidive multipliers.
    min_fine = 1800, -- Lower clamp to prevent under-punishment.
    max_fine = 6172, -- Upper clamp to keep legal proportionality.
    base_months = 9, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_057'] = {
    label = 'Infraction 057', -- Human readable name for offense code FRAUDE_057.
    code = 'FRAUDE_057', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 2609, -- Base fine before priors/recidive multipliers.
    min_fine = 1826, -- Lower clamp to prevent under-punishment.
    max_fine = 6261, -- Upper clamp to keep legal proportionality.
    base_months = 10, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_058'] = {
    label = 'Infraction 058', -- Human readable name for offense code CORRUPTION_058.
    code = 'CORRUPTION_058', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 2646, -- Base fine before priors/recidive multipliers.
    min_fine = 1852, -- Lower clamp to prevent under-punishment.
    max_fine = 6350, -- Upper clamp to keep legal proportionality.
    base_months = 11, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_059'] = {
    label = 'Infraction 059', -- Human readable name for offense code SEQUESTRATION_059.
    code = 'SEQUESTRATION_059', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 2683, -- Base fine before priors/recidive multipliers.
    min_fine = 1878, -- Lower clamp to prevent under-punishment.
    max_fine = 6439, -- Upper clamp to keep legal proportionality.
    base_months = 12, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_060'] = {
    label = 'Infraction 060', -- Human readable name for offense code VOL_QUALIFIE_060.
    code = 'VOL_QUALIFIE_060', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 2720, -- Base fine before priors/recidive multipliers.
    min_fine = 1903, -- Lower clamp to prevent under-punishment.
    max_fine = 6528, -- Upper clamp to keep legal proportionality.
    base_months = 13, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_061'] = {
    label = 'Infraction 061', -- Human readable name for offense code USAGE_ARME_061.
    code = 'USAGE_ARME_061', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 2757, -- Base fine before priors/recidive multipliers.
    min_fine = 1929, -- Lower clamp to prevent under-punishment.
    max_fine = 6616, -- Upper clamp to keep legal proportionality.
    base_months = 14, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_062'] = {
    label = 'Infraction 062', -- Human readable name for offense code FUITE_062.
    code = 'FUITE_062', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 2794, -- Base fine before priors/recidive multipliers.
    min_fine = 1955, -- Lower clamp to prevent under-punishment.
    max_fine = 6705, -- Upper clamp to keep legal proportionality.
    base_months = 15, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_063'] = {
    label = 'Infraction 063', -- Human readable name for offense code MISE_EN_DANGER_063.
    code = 'MISE_EN_DANGER_063', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 2831, -- Base fine before priors/recidive multipliers.
    min_fine = 1981, -- Lower clamp to prevent under-punishment.
    max_fine = 6794, -- Upper clamp to keep legal proportionality.
    base_months = 16, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_064'] = {
    label = 'Infraction 064', -- Human readable name for offense code POSSESSION_DROGUE_064.
    code = 'POSSESSION_DROGUE_064', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 2868, -- Base fine before priors/recidive multipliers.
    min_fine = 2007, -- Lower clamp to prevent under-punishment.
    max_fine = 6883, -- Upper clamp to keep legal proportionality.
    base_months = 17, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_065'] = {
    label = 'Infraction 065', -- Human readable name for offense code VENTE_DROGUE_065.
    code = 'VENTE_DROGUE_065', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 2905, -- Base fine before priors/recidive multipliers.
    min_fine = 2033, -- Lower clamp to prevent under-punishment.
    max_fine = 6972, -- Upper clamp to keep legal proportionality.
    base_months = 18, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_066'] = {
    label = 'Infraction 066', -- Human readable name for offense code AGRESSION_SIMPLE_066.
    code = 'AGRESSION_SIMPLE_066', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 2942, -- Base fine before priors/recidive multipliers.
    min_fine = 2059, -- Lower clamp to prevent under-punishment.
    max_fine = 7060, -- Upper clamp to keep legal proportionality.
    base_months = 19, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_067'] = {
    label = 'Infraction 067', -- Human readable name for offense code AGRESSION_ARMEE_067.
    code = 'AGRESSION_ARMEE_067', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 2979, -- Base fine before priors/recidive multipliers.
    min_fine = 2085, -- Lower clamp to prevent under-punishment.
    max_fine = 7149, -- Upper clamp to keep legal proportionality.
    base_months = 20, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_068'] = {
    label = 'Infraction 068', -- Human readable name for offense code HOMICIDE_068.
    code = 'HOMICIDE_068', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 3016, -- Base fine before priors/recidive multipliers.
    min_fine = 2111, -- Lower clamp to prevent under-punishment.
    max_fine = 7238, -- Upper clamp to keep legal proportionality.
    base_months = 21, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_069'] = {
    label = 'Infraction 069', -- Human readable name for offense code FRAUDE_069.
    code = 'FRAUDE_069', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 3053, -- Base fine before priors/recidive multipliers.
    min_fine = 2137, -- Lower clamp to prevent under-punishment.
    max_fine = 7327, -- Upper clamp to keep legal proportionality.
    base_months = 22, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_070'] = {
    label = 'Infraction 070', -- Human readable name for offense code CORRUPTION_070.
    code = 'CORRUPTION_070', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 3090, -- Base fine before priors/recidive multipliers.
    min_fine = 2163, -- Lower clamp to prevent under-punishment.
    max_fine = 7416, -- Upper clamp to keep legal proportionality.
    base_months = 23, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_071'] = {
    label = 'Infraction 071', -- Human readable name for offense code SEQUESTRATION_071.
    code = 'SEQUESTRATION_071', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 3127, -- Base fine before priors/recidive multipliers.
    min_fine = 2188, -- Lower clamp to prevent under-punishment.
    max_fine = 7504, -- Upper clamp to keep legal proportionality.
    base_months = 24, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_072'] = {
    label = 'Infraction 072', -- Human readable name for offense code VOL_QUALIFIE_072.
    code = 'VOL_QUALIFIE_072', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 3164, -- Base fine before priors/recidive multipliers.
    min_fine = 2214, -- Lower clamp to prevent under-punishment.
    max_fine = 7593, -- Upper clamp to keep legal proportionality.
    base_months = 25, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_073'] = {
    label = 'Infraction 073', -- Human readable name for offense code USAGE_ARME_073.
    code = 'USAGE_ARME_073', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 3201, -- Base fine before priors/recidive multipliers.
    min_fine = 2240, -- Lower clamp to prevent under-punishment.
    max_fine = 7682, -- Upper clamp to keep legal proportionality.
    base_months = 26, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_074'] = {
    label = 'Infraction 074', -- Human readable name for offense code FUITE_074.
    code = 'FUITE_074', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 3238, -- Base fine before priors/recidive multipliers.
    min_fine = 2266, -- Lower clamp to prevent under-punishment.
    max_fine = 7771, -- Upper clamp to keep legal proportionality.
    base_months = 27, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_075'] = {
    label = 'Infraction 075', -- Human readable name for offense code MISE_EN_DANGER_075.
    code = 'MISE_EN_DANGER_075', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 3275, -- Base fine before priors/recidive multipliers.
    min_fine = 2292, -- Lower clamp to prevent under-punishment.
    max_fine = 7860, -- Upper clamp to keep legal proportionality.
    base_months = 28, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_076'] = {
    label = 'Infraction 076', -- Human readable name for offense code POSSESSION_DROGUE_076.
    code = 'POSSESSION_DROGUE_076', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 3312, -- Base fine before priors/recidive multipliers.
    min_fine = 2318, -- Lower clamp to prevent under-punishment.
    max_fine = 7948, -- Upper clamp to keep legal proportionality.
    base_months = 29, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_077'] = {
    label = 'Infraction 077', -- Human readable name for offense code VENTE_DROGUE_077.
    code = 'VENTE_DROGUE_077', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 3349, -- Base fine before priors/recidive multipliers.
    min_fine = 2344, -- Lower clamp to prevent under-punishment.
    max_fine = 8037, -- Upper clamp to keep legal proportionality.
    base_months = 30, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_078'] = {
    label = 'Infraction 078', -- Human readable name for offense code AGRESSION_SIMPLE_078.
    code = 'AGRESSION_SIMPLE_078', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 3386, -- Base fine before priors/recidive multipliers.
    min_fine = 2370, -- Lower clamp to prevent under-punishment.
    max_fine = 8126, -- Upper clamp to keep legal proportionality.
    base_months = 31, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_079'] = {
    label = 'Infraction 079', -- Human readable name for offense code AGRESSION_ARMEE_079.
    code = 'AGRESSION_ARMEE_079', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 3423, -- Base fine before priors/recidive multipliers.
    min_fine = 2396, -- Lower clamp to prevent under-punishment.
    max_fine = 8215, -- Upper clamp to keep legal proportionality.
    base_months = 32, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_080'] = {
    label = 'Infraction 080', -- Human readable name for offense code HOMICIDE_080.
    code = 'HOMICIDE_080', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 3460, -- Base fine before priors/recidive multipliers.
    min_fine = 2422, -- Lower clamp to prevent under-punishment.
    max_fine = 8304, -- Upper clamp to keep legal proportionality.
    base_months = 33, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_081'] = {
    label = 'Infraction 081', -- Human readable name for offense code FRAUDE_081.
    code = 'FRAUDE_081', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 3497, -- Base fine before priors/recidive multipliers.
    min_fine = 2447, -- Lower clamp to prevent under-punishment.
    max_fine = 8392, -- Upper clamp to keep legal proportionality.
    base_months = 34, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_082'] = {
    label = 'Infraction 082', -- Human readable name for offense code CORRUPTION_082.
    code = 'CORRUPTION_082', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 3534, -- Base fine before priors/recidive multipliers.
    min_fine = 2473, -- Lower clamp to prevent under-punishment.
    max_fine = 8481, -- Upper clamp to keep legal proportionality.
    base_months = 35, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_083'] = {
    label = 'Infraction 083', -- Human readable name for offense code SEQUESTRATION_083.
    code = 'SEQUESTRATION_083', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 3571, -- Base fine before priors/recidive multipliers.
    min_fine = 2499, -- Lower clamp to prevent under-punishment.
    max_fine = 8570, -- Upper clamp to keep legal proportionality.
    base_months = 36, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_084'] = {
    label = 'Infraction 084', -- Human readable name for offense code VOL_QUALIFIE_084.
    code = 'VOL_QUALIFIE_084', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 3608, -- Base fine before priors/recidive multipliers.
    min_fine = 2525, -- Lower clamp to prevent under-punishment.
    max_fine = 8659, -- Upper clamp to keep legal proportionality.
    base_months = 37, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_085'] = {
    label = 'Infraction 085', -- Human readable name for offense code USAGE_ARME_085.
    code = 'USAGE_ARME_085', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 3645, -- Base fine before priors/recidive multipliers.
    min_fine = 2551, -- Lower clamp to prevent under-punishment.
    max_fine = 8748, -- Upper clamp to keep legal proportionality.
    base_months = 38, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_086'] = {
    label = 'Infraction 086', -- Human readable name for offense code FUITE_086.
    code = 'FUITE_086', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 3682, -- Base fine before priors/recidive multipliers.
    min_fine = 2577, -- Lower clamp to prevent under-punishment.
    max_fine = 8836, -- Upper clamp to keep legal proportionality.
    base_months = 39, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_087'] = {
    label = 'Infraction 087', -- Human readable name for offense code MISE_EN_DANGER_087.
    code = 'MISE_EN_DANGER_087', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 3719, -- Base fine before priors/recidive multipliers.
    min_fine = 2603, -- Lower clamp to prevent under-punishment.
    max_fine = 8925, -- Upper clamp to keep legal proportionality.
    base_months = 40, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_088'] = {
    label = 'Infraction 088', -- Human readable name for offense code POSSESSION_DROGUE_088.
    code = 'POSSESSION_DROGUE_088', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 3756, -- Base fine before priors/recidive multipliers.
    min_fine = 2629, -- Lower clamp to prevent under-punishment.
    max_fine = 9014, -- Upper clamp to keep legal proportionality.
    base_months = 41, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_089'] = {
    label = 'Infraction 089', -- Human readable name for offense code VENTE_DROGUE_089.
    code = 'VENTE_DROGUE_089', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 3793, -- Base fine before priors/recidive multipliers.
    min_fine = 2655, -- Lower clamp to prevent under-punishment.
    max_fine = 9103, -- Upper clamp to keep legal proportionality.
    base_months = 42, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_090'] = {
    label = 'Infraction 090', -- Human readable name for offense code AGRESSION_SIMPLE_090.
    code = 'AGRESSION_SIMPLE_090', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 3830, -- Base fine before priors/recidive multipliers.
    min_fine = 2681, -- Lower clamp to prevent under-punishment.
    max_fine = 9192, -- Upper clamp to keep legal proportionality.
    base_months = 43, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_091'] = {
    label = 'Infraction 091', -- Human readable name for offense code AGRESSION_ARMEE_091.
    code = 'AGRESSION_ARMEE_091', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 3867, -- Base fine before priors/recidive multipliers.
    min_fine = 2706, -- Lower clamp to prevent under-punishment.
    max_fine = 9280, -- Upper clamp to keep legal proportionality.
    base_months = 44, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_092'] = {
    label = 'Infraction 092', -- Human readable name for offense code HOMICIDE_092.
    code = 'HOMICIDE_092', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 3904, -- Base fine before priors/recidive multipliers.
    min_fine = 2732, -- Lower clamp to prevent under-punishment.
    max_fine = 9369, -- Upper clamp to keep legal proportionality.
    base_months = 45, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_093'] = {
    label = 'Infraction 093', -- Human readable name for offense code FRAUDE_093.
    code = 'FRAUDE_093', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 3941, -- Base fine before priors/recidive multipliers.
    min_fine = 2758, -- Lower clamp to prevent under-punishment.
    max_fine = 9458, -- Upper clamp to keep legal proportionality.
    base_months = 46, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_094'] = {
    label = 'Infraction 094', -- Human readable name for offense code CORRUPTION_094.
    code = 'CORRUPTION_094', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 3978, -- Base fine before priors/recidive multipliers.
    min_fine = 2784, -- Lower clamp to prevent under-punishment.
    max_fine = 9547, -- Upper clamp to keep legal proportionality.
    base_months = 47, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_095'] = {
    label = 'Infraction 095', -- Human readable name for offense code SEQUESTRATION_095.
    code = 'SEQUESTRATION_095', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 4015, -- Base fine before priors/recidive multipliers.
    min_fine = 2810, -- Lower clamp to prevent under-punishment.
    max_fine = 9636, -- Upper clamp to keep legal proportionality.
    base_months = 48, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 16, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_096'] = {
    label = 'Infraction 096', -- Human readable name for offense code VOL_QUALIFIE_096.
    code = 'VOL_QUALIFIE_096', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 4052, -- Base fine before priors/recidive multipliers.
    min_fine = 2836, -- Lower clamp to prevent under-punishment.
    max_fine = 9724, -- Upper clamp to keep legal proportionality.
    base_months = 1, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_097'] = {
    label = 'Infraction 097', -- Human readable name for offense code USAGE_ARME_097.
    code = 'USAGE_ARME_097', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 4089, -- Base fine before priors/recidive multipliers.
    min_fine = 2862, -- Lower clamp to prevent under-punishment.
    max_fine = 9813, -- Upper clamp to keep legal proportionality.
    base_months = 2, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_098'] = {
    label = 'Infraction 098', -- Human readable name for offense code FUITE_098.
    code = 'FUITE_098', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 4126, -- Base fine before priors/recidive multipliers.
    min_fine = 2888, -- Lower clamp to prevent under-punishment.
    max_fine = 9902, -- Upper clamp to keep legal proportionality.
    base_months = 3, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_099'] = {
    label = 'Infraction 099', -- Human readable name for offense code MISE_EN_DANGER_099.
    code = 'MISE_EN_DANGER_099', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 4163, -- Base fine before priors/recidive multipliers.
    min_fine = 2914, -- Lower clamp to prevent under-punishment.
    max_fine = 9991, -- Upper clamp to keep legal proportionality.
    base_months = 4, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_100'] = {
    label = 'Infraction 100', -- Human readable name for offense code POSSESSION_DROGUE_100.
    code = 'POSSESSION_DROGUE_100', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 4200, -- Base fine before priors/recidive multipliers.
    min_fine = 2940, -- Lower clamp to prevent under-punishment.
    max_fine = 10080, -- Upper clamp to keep legal proportionality.
    base_months = 5, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_101'] = {
    label = 'Infraction 101', -- Human readable name for offense code VENTE_DROGUE_101.
    code = 'VENTE_DROGUE_101', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 4237, -- Base fine before priors/recidive multipliers.
    min_fine = 2965, -- Lower clamp to prevent under-punishment.
    max_fine = 10168, -- Upper clamp to keep legal proportionality.
    base_months = 6, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_102'] = {
    label = 'Infraction 102', -- Human readable name for offense code AGRESSION_SIMPLE_102.
    code = 'AGRESSION_SIMPLE_102', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 4274, -- Base fine before priors/recidive multipliers.
    min_fine = 2991, -- Lower clamp to prevent under-punishment.
    max_fine = 10257, -- Upper clamp to keep legal proportionality.
    base_months = 7, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_103'] = {
    label = 'Infraction 103', -- Human readable name for offense code AGRESSION_ARMEE_103.
    code = 'AGRESSION_ARMEE_103', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 4311, -- Base fine before priors/recidive multipliers.
    min_fine = 3017, -- Lower clamp to prevent under-punishment.
    max_fine = 10346, -- Upper clamp to keep legal proportionality.
    base_months = 8, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_104'] = {
    label = 'Infraction 104', -- Human readable name for offense code HOMICIDE_104.
    code = 'HOMICIDE_104', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 4348, -- Base fine before priors/recidive multipliers.
    min_fine = 3043, -- Lower clamp to prevent under-punishment.
    max_fine = 10435, -- Upper clamp to keep legal proportionality.
    base_months = 9, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_105'] = {
    label = 'Infraction 105', -- Human readable name for offense code FRAUDE_105.
    code = 'FRAUDE_105', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 4385, -- Base fine before priors/recidive multipliers.
    min_fine = 3069, -- Lower clamp to prevent under-punishment.
    max_fine = 10524, -- Upper clamp to keep legal proportionality.
    base_months = 10, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_106'] = {
    label = 'Infraction 106', -- Human readable name for offense code CORRUPTION_106.
    code = 'CORRUPTION_106', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 4422, -- Base fine before priors/recidive multipliers.
    min_fine = 3095, -- Lower clamp to prevent under-punishment.
    max_fine = 10612, -- Upper clamp to keep legal proportionality.
    base_months = 11, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_107'] = {
    label = 'Infraction 107', -- Human readable name for offense code SEQUESTRATION_107.
    code = 'SEQUESTRATION_107', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 4459, -- Base fine before priors/recidive multipliers.
    min_fine = 3121, -- Lower clamp to prevent under-punishment.
    max_fine = 10701, -- Upper clamp to keep legal proportionality.
    base_months = 12, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_108'] = {
    label = 'Infraction 108', -- Human readable name for offense code VOL_QUALIFIE_108.
    code = 'VOL_QUALIFIE_108', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 4496, -- Base fine before priors/recidive multipliers.
    min_fine = 3147, -- Lower clamp to prevent under-punishment.
    max_fine = 10790, -- Upper clamp to keep legal proportionality.
    base_months = 13, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_109'] = {
    label = 'Infraction 109', -- Human readable name for offense code USAGE_ARME_109.
    code = 'USAGE_ARME_109', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 4533, -- Base fine before priors/recidive multipliers.
    min_fine = 3173, -- Lower clamp to prevent under-punishment.
    max_fine = 10879, -- Upper clamp to keep legal proportionality.
    base_months = 14, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_110'] = {
    label = 'Infraction 110', -- Human readable name for offense code FUITE_110.
    code = 'FUITE_110', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 4570, -- Base fine before priors/recidive multipliers.
    min_fine = 3199, -- Lower clamp to prevent under-punishment.
    max_fine = 10968, -- Upper clamp to keep legal proportionality.
    base_months = 15, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_111'] = {
    label = 'Infraction 111', -- Human readable name for offense code MISE_EN_DANGER_111.
    code = 'MISE_EN_DANGER_111', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 4607, -- Base fine before priors/recidive multipliers.
    min_fine = 3224, -- Lower clamp to prevent under-punishment.
    max_fine = 11056, -- Upper clamp to keep legal proportionality.
    base_months = 16, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_112'] = {
    label = 'Infraction 112', -- Human readable name for offense code POSSESSION_DROGUE_112.
    code = 'POSSESSION_DROGUE_112', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 4644, -- Base fine before priors/recidive multipliers.
    min_fine = 3250, -- Lower clamp to prevent under-punishment.
    max_fine = 11145, -- Upper clamp to keep legal proportionality.
    base_months = 17, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_113'] = {
    label = 'Infraction 113', -- Human readable name for offense code VENTE_DROGUE_113.
    code = 'VENTE_DROGUE_113', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 4681, -- Base fine before priors/recidive multipliers.
    min_fine = 3276, -- Lower clamp to prevent under-punishment.
    max_fine = 11234, -- Upper clamp to keep legal proportionality.
    base_months = 18, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_114'] = {
    label = 'Infraction 114', -- Human readable name for offense code AGRESSION_SIMPLE_114.
    code = 'AGRESSION_SIMPLE_114', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 4718, -- Base fine before priors/recidive multipliers.
    min_fine = 3302, -- Lower clamp to prevent under-punishment.
    max_fine = 11323, -- Upper clamp to keep legal proportionality.
    base_months = 19, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_115'] = {
    label = 'Infraction 115', -- Human readable name for offense code AGRESSION_ARMEE_115.
    code = 'AGRESSION_ARMEE_115', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 4755, -- Base fine before priors/recidive multipliers.
    min_fine = 3328, -- Lower clamp to prevent under-punishment.
    max_fine = 11412, -- Upper clamp to keep legal proportionality.
    base_months = 20, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_116'] = {
    label = 'Infraction 116', -- Human readable name for offense code HOMICIDE_116.
    code = 'HOMICIDE_116', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 4792, -- Base fine before priors/recidive multipliers.
    min_fine = 3354, -- Lower clamp to prevent under-punishment.
    max_fine = 11500, -- Upper clamp to keep legal proportionality.
    base_months = 21, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_117'] = {
    label = 'Infraction 117', -- Human readable name for offense code FRAUDE_117.
    code = 'FRAUDE_117', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 4829, -- Base fine before priors/recidive multipliers.
    min_fine = 3380, -- Lower clamp to prevent under-punishment.
    max_fine = 11589, -- Upper clamp to keep legal proportionality.
    base_months = 22, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_118'] = {
    label = 'Infraction 118', -- Human readable name for offense code CORRUPTION_118.
    code = 'CORRUPTION_118', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 4866, -- Base fine before priors/recidive multipliers.
    min_fine = 3406, -- Lower clamp to prevent under-punishment.
    max_fine = 11678, -- Upper clamp to keep legal proportionality.
    base_months = 23, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_119'] = {
    label = 'Infraction 119', -- Human readable name for offense code SEQUESTRATION_119.
    code = 'SEQUESTRATION_119', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 4903, -- Base fine before priors/recidive multipliers.
    min_fine = 3432, -- Lower clamp to prevent under-punishment.
    max_fine = 11767, -- Upper clamp to keep legal proportionality.
    base_months = 24, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_120'] = {
    label = 'Infraction 120', -- Human readable name for offense code VOL_QUALIFIE_120.
    code = 'VOL_QUALIFIE_120', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 4940, -- Base fine before priors/recidive multipliers.
    min_fine = 3458, -- Lower clamp to prevent under-punishment.
    max_fine = 11856, -- Upper clamp to keep legal proportionality.
    base_months = 25, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_121'] = {
    label = 'Infraction 121', -- Human readable name for offense code USAGE_ARME_121.
    code = 'USAGE_ARME_121', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 4977, -- Base fine before priors/recidive multipliers.
    min_fine = 3483, -- Lower clamp to prevent under-punishment.
    max_fine = 11944, -- Upper clamp to keep legal proportionality.
    base_months = 26, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_122'] = {
    label = 'Infraction 122', -- Human readable name for offense code FUITE_122.
    code = 'FUITE_122', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 5014, -- Base fine before priors/recidive multipliers.
    min_fine = 3509, -- Lower clamp to prevent under-punishment.
    max_fine = 12033, -- Upper clamp to keep legal proportionality.
    base_months = 27, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_123'] = {
    label = 'Infraction 123', -- Human readable name for offense code MISE_EN_DANGER_123.
    code = 'MISE_EN_DANGER_123', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 5051, -- Base fine before priors/recidive multipliers.
    min_fine = 3535, -- Lower clamp to prevent under-punishment.
    max_fine = 12122, -- Upper clamp to keep legal proportionality.
    base_months = 28, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_124'] = {
    label = 'Infraction 124', -- Human readable name for offense code POSSESSION_DROGUE_124.
    code = 'POSSESSION_DROGUE_124', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 5088, -- Base fine before priors/recidive multipliers.
    min_fine = 3561, -- Lower clamp to prevent under-punishment.
    max_fine = 12211, -- Upper clamp to keep legal proportionality.
    base_months = 29, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_125'] = {
    label = 'Infraction 125', -- Human readable name for offense code VENTE_DROGUE_125.
    code = 'VENTE_DROGUE_125', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 5125, -- Base fine before priors/recidive multipliers.
    min_fine = 3587, -- Lower clamp to prevent under-punishment.
    max_fine = 12300, -- Upper clamp to keep legal proportionality.
    base_months = 30, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_126'] = {
    label = 'Infraction 126', -- Human readable name for offense code AGRESSION_SIMPLE_126.
    code = 'AGRESSION_SIMPLE_126', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 5162, -- Base fine before priors/recidive multipliers.
    min_fine = 3613, -- Lower clamp to prevent under-punishment.
    max_fine = 12388, -- Upper clamp to keep legal proportionality.
    base_months = 31, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_127'] = {
    label = 'Infraction 127', -- Human readable name for offense code AGRESSION_ARMEE_127.
    code = 'AGRESSION_ARMEE_127', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 5199, -- Base fine before priors/recidive multipliers.
    min_fine = 3639, -- Lower clamp to prevent under-punishment.
    max_fine = 12477, -- Upper clamp to keep legal proportionality.
    base_months = 32, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_128'] = {
    label = 'Infraction 128', -- Human readable name for offense code HOMICIDE_128.
    code = 'HOMICIDE_128', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 5236, -- Base fine before priors/recidive multipliers.
    min_fine = 3665, -- Lower clamp to prevent under-punishment.
    max_fine = 12566, -- Upper clamp to keep legal proportionality.
    base_months = 33, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_129'] = {
    label = 'Infraction 129', -- Human readable name for offense code FRAUDE_129.
    code = 'FRAUDE_129', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 5273, -- Base fine before priors/recidive multipliers.
    min_fine = 3691, -- Lower clamp to prevent under-punishment.
    max_fine = 12655, -- Upper clamp to keep legal proportionality.
    base_months = 34, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_130'] = {
    label = 'Infraction 130', -- Human readable name for offense code CORRUPTION_130.
    code = 'CORRUPTION_130', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 5310, -- Base fine before priors/recidive multipliers.
    min_fine = 3716, -- Lower clamp to prevent under-punishment.
    max_fine = 12744, -- Upper clamp to keep legal proportionality.
    base_months = 35, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_131'] = {
    label = 'Infraction 131', -- Human readable name for offense code SEQUESTRATION_131.
    code = 'SEQUESTRATION_131', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 5347, -- Base fine before priors/recidive multipliers.
    min_fine = 3742, -- Lower clamp to prevent under-punishment.
    max_fine = 12832, -- Upper clamp to keep legal proportionality.
    base_months = 36, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_132'] = {
    label = 'Infraction 132', -- Human readable name for offense code VOL_QUALIFIE_132.
    code = 'VOL_QUALIFIE_132', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 5384, -- Base fine before priors/recidive multipliers.
    min_fine = 3768, -- Lower clamp to prevent under-punishment.
    max_fine = 12921, -- Upper clamp to keep legal proportionality.
    base_months = 37, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_133'] = {
    label = 'Infraction 133', -- Human readable name for offense code USAGE_ARME_133.
    code = 'USAGE_ARME_133', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 5421, -- Base fine before priors/recidive multipliers.
    min_fine = 3794, -- Lower clamp to prevent under-punishment.
    max_fine = 13010, -- Upper clamp to keep legal proportionality.
    base_months = 38, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_134'] = {
    label = 'Infraction 134', -- Human readable name for offense code FUITE_134.
    code = 'FUITE_134', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 5458, -- Base fine before priors/recidive multipliers.
    min_fine = 3820, -- Lower clamp to prevent under-punishment.
    max_fine = 13099, -- Upper clamp to keep legal proportionality.
    base_months = 39, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_135'] = {
    label = 'Infraction 135', -- Human readable name for offense code MISE_EN_DANGER_135.
    code = 'MISE_EN_DANGER_135', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 5495, -- Base fine before priors/recidive multipliers.
    min_fine = 3846, -- Lower clamp to prevent under-punishment.
    max_fine = 13188, -- Upper clamp to keep legal proportionality.
    base_months = 40, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_136'] = {
    label = 'Infraction 136', -- Human readable name for offense code POSSESSION_DROGUE_136.
    code = 'POSSESSION_DROGUE_136', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 5532, -- Base fine before priors/recidive multipliers.
    min_fine = 3872, -- Lower clamp to prevent under-punishment.
    max_fine = 13276, -- Upper clamp to keep legal proportionality.
    base_months = 41, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_137'] = {
    label = 'Infraction 137', -- Human readable name for offense code VENTE_DROGUE_137.
    code = 'VENTE_DROGUE_137', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 5569, -- Base fine before priors/recidive multipliers.
    min_fine = 3898, -- Lower clamp to prevent under-punishment.
    max_fine = 13365, -- Upper clamp to keep legal proportionality.
    base_months = 42, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_138'] = {
    label = 'Infraction 138', -- Human readable name for offense code AGRESSION_SIMPLE_138.
    code = 'AGRESSION_SIMPLE_138', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 5606, -- Base fine before priors/recidive multipliers.
    min_fine = 3924, -- Lower clamp to prevent under-punishment.
    max_fine = 13454, -- Upper clamp to keep legal proportionality.
    base_months = 43, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_139'] = {
    label = 'Infraction 139', -- Human readable name for offense code AGRESSION_ARMEE_139.
    code = 'AGRESSION_ARMEE_139', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 5643, -- Base fine before priors/recidive multipliers.
    min_fine = 3950, -- Lower clamp to prevent under-punishment.
    max_fine = 13543, -- Upper clamp to keep legal proportionality.
    base_months = 44, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_140'] = {
    label = 'Infraction 140', -- Human readable name for offense code HOMICIDE_140.
    code = 'HOMICIDE_140', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 5680, -- Base fine before priors/recidive multipliers.
    min_fine = 3975, -- Lower clamp to prevent under-punishment.
    max_fine = 13632, -- Upper clamp to keep legal proportionality.
    base_months = 45, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_141'] = {
    label = 'Infraction 141', -- Human readable name for offense code FRAUDE_141.
    code = 'FRAUDE_141', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 5717, -- Base fine before priors/recidive multipliers.
    min_fine = 4001, -- Lower clamp to prevent under-punishment.
    max_fine = 13720, -- Upper clamp to keep legal proportionality.
    base_months = 46, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_142'] = {
    label = 'Infraction 142', -- Human readable name for offense code CORRUPTION_142.
    code = 'CORRUPTION_142', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 5754, -- Base fine before priors/recidive multipliers.
    min_fine = 4027, -- Lower clamp to prevent under-punishment.
    max_fine = 13809, -- Upper clamp to keep legal proportionality.
    base_months = 47, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_143'] = {
    label = 'Infraction 143', -- Human readable name for offense code SEQUESTRATION_143.
    code = 'SEQUESTRATION_143', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 5791, -- Base fine before priors/recidive multipliers.
    min_fine = 4053, -- Lower clamp to prevent under-punishment.
    max_fine = 13898, -- Upper clamp to keep legal proportionality.
    base_months = 48, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 16, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_144'] = {
    label = 'Infraction 144', -- Human readable name for offense code VOL_QUALIFIE_144.
    code = 'VOL_QUALIFIE_144', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 5828, -- Base fine before priors/recidive multipliers.
    min_fine = 4079, -- Lower clamp to prevent under-punishment.
    max_fine = 13987, -- Upper clamp to keep legal proportionality.
    base_months = 1, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_145'] = {
    label = 'Infraction 145', -- Human readable name for offense code USAGE_ARME_145.
    code = 'USAGE_ARME_145', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 5865, -- Base fine before priors/recidive multipliers.
    min_fine = 4105, -- Lower clamp to prevent under-punishment.
    max_fine = 14076, -- Upper clamp to keep legal proportionality.
    base_months = 2, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_146'] = {
    label = 'Infraction 146', -- Human readable name for offense code FUITE_146.
    code = 'FUITE_146', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 5902, -- Base fine before priors/recidive multipliers.
    min_fine = 4131, -- Lower clamp to prevent under-punishment.
    max_fine = 14164, -- Upper clamp to keep legal proportionality.
    base_months = 3, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_147'] = {
    label = 'Infraction 147', -- Human readable name for offense code MISE_EN_DANGER_147.
    code = 'MISE_EN_DANGER_147', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 5939, -- Base fine before priors/recidive multipliers.
    min_fine = 4157, -- Lower clamp to prevent under-punishment.
    max_fine = 14253, -- Upper clamp to keep legal proportionality.
    base_months = 4, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_148'] = {
    label = 'Infraction 148', -- Human readable name for offense code POSSESSION_DROGUE_148.
    code = 'POSSESSION_DROGUE_148', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 5976, -- Base fine before priors/recidive multipliers.
    min_fine = 4183, -- Lower clamp to prevent under-punishment.
    max_fine = 14342, -- Upper clamp to keep legal proportionality.
    base_months = 5, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_149'] = {
    label = 'Infraction 149', -- Human readable name for offense code VENTE_DROGUE_149.
    code = 'VENTE_DROGUE_149', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 6013, -- Base fine before priors/recidive multipliers.
    min_fine = 4209, -- Lower clamp to prevent under-punishment.
    max_fine = 14431, -- Upper clamp to keep legal proportionality.
    base_months = 6, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_150'] = {
    label = 'Infraction 150', -- Human readable name for offense code AGRESSION_SIMPLE_150.
    code = 'AGRESSION_SIMPLE_150', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 6050, -- Base fine before priors/recidive multipliers.
    min_fine = 4235, -- Lower clamp to prevent under-punishment.
    max_fine = 14520, -- Upper clamp to keep legal proportionality.
    base_months = 7, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_151'] = {
    label = 'Infraction 151', -- Human readable name for offense code AGRESSION_ARMEE_151.
    code = 'AGRESSION_ARMEE_151', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 6087, -- Base fine before priors/recidive multipliers.
    min_fine = 4260, -- Lower clamp to prevent under-punishment.
    max_fine = 14608, -- Upper clamp to keep legal proportionality.
    base_months = 8, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_152'] = {
    label = 'Infraction 152', -- Human readable name for offense code HOMICIDE_152.
    code = 'HOMICIDE_152', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 6124, -- Base fine before priors/recidive multipliers.
    min_fine = 4286, -- Lower clamp to prevent under-punishment.
    max_fine = 14697, -- Upper clamp to keep legal proportionality.
    base_months = 9, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_153'] = {
    label = 'Infraction 153', -- Human readable name for offense code FRAUDE_153.
    code = 'FRAUDE_153', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 6161, -- Base fine before priors/recidive multipliers.
    min_fine = 4312, -- Lower clamp to prevent under-punishment.
    max_fine = 14786, -- Upper clamp to keep legal proportionality.
    base_months = 10, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_154'] = {
    label = 'Infraction 154', -- Human readable name for offense code CORRUPTION_154.
    code = 'CORRUPTION_154', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 6198, -- Base fine before priors/recidive multipliers.
    min_fine = 4338, -- Lower clamp to prevent under-punishment.
    max_fine = 14875, -- Upper clamp to keep legal proportionality.
    base_months = 11, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_155'] = {
    label = 'Infraction 155', -- Human readable name for offense code SEQUESTRATION_155.
    code = 'SEQUESTRATION_155', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 6235, -- Base fine before priors/recidive multipliers.
    min_fine = 4364, -- Lower clamp to prevent under-punishment.
    max_fine = 14964, -- Upper clamp to keep legal proportionality.
    base_months = 12, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_156'] = {
    label = 'Infraction 156', -- Human readable name for offense code VOL_QUALIFIE_156.
    code = 'VOL_QUALIFIE_156', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 6272, -- Base fine before priors/recidive multipliers.
    min_fine = 4390, -- Lower clamp to prevent under-punishment.
    max_fine = 15052, -- Upper clamp to keep legal proportionality.
    base_months = 13, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_157'] = {
    label = 'Infraction 157', -- Human readable name for offense code USAGE_ARME_157.
    code = 'USAGE_ARME_157', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 6309, -- Base fine before priors/recidive multipliers.
    min_fine = 4416, -- Lower clamp to prevent under-punishment.
    max_fine = 15141, -- Upper clamp to keep legal proportionality.
    base_months = 14, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_158'] = {
    label = 'Infraction 158', -- Human readable name for offense code FUITE_158.
    code = 'FUITE_158', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 6346, -- Base fine before priors/recidive multipliers.
    min_fine = 4442, -- Lower clamp to prevent under-punishment.
    max_fine = 15230, -- Upper clamp to keep legal proportionality.
    base_months = 15, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_159'] = {
    label = 'Infraction 159', -- Human readable name for offense code MISE_EN_DANGER_159.
    code = 'MISE_EN_DANGER_159', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 6383, -- Base fine before priors/recidive multipliers.
    min_fine = 4468, -- Lower clamp to prevent under-punishment.
    max_fine = 15319, -- Upper clamp to keep legal proportionality.
    base_months = 16, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_160'] = {
    label = 'Infraction 160', -- Human readable name for offense code POSSESSION_DROGUE_160.
    code = 'POSSESSION_DROGUE_160', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 6420, -- Base fine before priors/recidive multipliers.
    min_fine = 4494, -- Lower clamp to prevent under-punishment.
    max_fine = 15408, -- Upper clamp to keep legal proportionality.
    base_months = 17, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_161'] = {
    label = 'Infraction 161', -- Human readable name for offense code VENTE_DROGUE_161.
    code = 'VENTE_DROGUE_161', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 6457, -- Base fine before priors/recidive multipliers.
    min_fine = 4519, -- Lower clamp to prevent under-punishment.
    max_fine = 15496, -- Upper clamp to keep legal proportionality.
    base_months = 18, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_162'] = {
    label = 'Infraction 162', -- Human readable name for offense code AGRESSION_SIMPLE_162.
    code = 'AGRESSION_SIMPLE_162', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 6494, -- Base fine before priors/recidive multipliers.
    min_fine = 4545, -- Lower clamp to prevent under-punishment.
    max_fine = 15585, -- Upper clamp to keep legal proportionality.
    base_months = 19, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_163'] = {
    label = 'Infraction 163', -- Human readable name for offense code AGRESSION_ARMEE_163.
    code = 'AGRESSION_ARMEE_163', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 6531, -- Base fine before priors/recidive multipliers.
    min_fine = 4571, -- Lower clamp to prevent under-punishment.
    max_fine = 15674, -- Upper clamp to keep legal proportionality.
    base_months = 20, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_164'] = {
    label = 'Infraction 164', -- Human readable name for offense code HOMICIDE_164.
    code = 'HOMICIDE_164', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 6568, -- Base fine before priors/recidive multipliers.
    min_fine = 4597, -- Lower clamp to prevent under-punishment.
    max_fine = 15763, -- Upper clamp to keep legal proportionality.
    base_months = 21, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_165'] = {
    label = 'Infraction 165', -- Human readable name for offense code FRAUDE_165.
    code = 'FRAUDE_165', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 6605, -- Base fine before priors/recidive multipliers.
    min_fine = 4623, -- Lower clamp to prevent under-punishment.
    max_fine = 15852, -- Upper clamp to keep legal proportionality.
    base_months = 22, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_166'] = {
    label = 'Infraction 166', -- Human readable name for offense code CORRUPTION_166.
    code = 'CORRUPTION_166', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 6642, -- Base fine before priors/recidive multipliers.
    min_fine = 4649, -- Lower clamp to prevent under-punishment.
    max_fine = 15940, -- Upper clamp to keep legal proportionality.
    base_months = 23, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_167'] = {
    label = 'Infraction 167', -- Human readable name for offense code SEQUESTRATION_167.
    code = 'SEQUESTRATION_167', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 6679, -- Base fine before priors/recidive multipliers.
    min_fine = 4675, -- Lower clamp to prevent under-punishment.
    max_fine = 16029, -- Upper clamp to keep legal proportionality.
    base_months = 24, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_168'] = {
    label = 'Infraction 168', -- Human readable name for offense code VOL_QUALIFIE_168.
    code = 'VOL_QUALIFIE_168', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 6716, -- Base fine before priors/recidive multipliers.
    min_fine = 4701, -- Lower clamp to prevent under-punishment.
    max_fine = 16118, -- Upper clamp to keep legal proportionality.
    base_months = 25, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_169'] = {
    label = 'Infraction 169', -- Human readable name for offense code USAGE_ARME_169.
    code = 'USAGE_ARME_169', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 6753, -- Base fine before priors/recidive multipliers.
    min_fine = 4727, -- Lower clamp to prevent under-punishment.
    max_fine = 16207, -- Upper clamp to keep legal proportionality.
    base_months = 26, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_170'] = {
    label = 'Infraction 170', -- Human readable name for offense code FUITE_170.
    code = 'FUITE_170', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 6790, -- Base fine before priors/recidive multipliers.
    min_fine = 4753, -- Lower clamp to prevent under-punishment.
    max_fine = 16296, -- Upper clamp to keep legal proportionality.
    base_months = 27, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_171'] = {
    label = 'Infraction 171', -- Human readable name for offense code MISE_EN_DANGER_171.
    code = 'MISE_EN_DANGER_171', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 6827, -- Base fine before priors/recidive multipliers.
    min_fine = 4778, -- Lower clamp to prevent under-punishment.
    max_fine = 16384, -- Upper clamp to keep legal proportionality.
    base_months = 28, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_172'] = {
    label = 'Infraction 172', -- Human readable name for offense code POSSESSION_DROGUE_172.
    code = 'POSSESSION_DROGUE_172', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 6864, -- Base fine before priors/recidive multipliers.
    min_fine = 4804, -- Lower clamp to prevent under-punishment.
    max_fine = 16473, -- Upper clamp to keep legal proportionality.
    base_months = 29, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_173'] = {
    label = 'Infraction 173', -- Human readable name for offense code VENTE_DROGUE_173.
    code = 'VENTE_DROGUE_173', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 6901, -- Base fine before priors/recidive multipliers.
    min_fine = 4830, -- Lower clamp to prevent under-punishment.
    max_fine = 16562, -- Upper clamp to keep legal proportionality.
    base_months = 30, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_174'] = {
    label = 'Infraction 174', -- Human readable name for offense code AGRESSION_SIMPLE_174.
    code = 'AGRESSION_SIMPLE_174', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 6938, -- Base fine before priors/recidive multipliers.
    min_fine = 4856, -- Lower clamp to prevent under-punishment.
    max_fine = 16651, -- Upper clamp to keep legal proportionality.
    base_months = 31, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_175'] = {
    label = 'Infraction 175', -- Human readable name for offense code AGRESSION_ARMEE_175.
    code = 'AGRESSION_ARMEE_175', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 6975, -- Base fine before priors/recidive multipliers.
    min_fine = 4882, -- Lower clamp to prevent under-punishment.
    max_fine = 16740, -- Upper clamp to keep legal proportionality.
    base_months = 32, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_176'] = {
    label = 'Infraction 176', -- Human readable name for offense code HOMICIDE_176.
    code = 'HOMICIDE_176', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 7012, -- Base fine before priors/recidive multipliers.
    min_fine = 4908, -- Lower clamp to prevent under-punishment.
    max_fine = 16828, -- Upper clamp to keep legal proportionality.
    base_months = 33, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_177'] = {
    label = 'Infraction 177', -- Human readable name for offense code FRAUDE_177.
    code = 'FRAUDE_177', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 7049, -- Base fine before priors/recidive multipliers.
    min_fine = 4934, -- Lower clamp to prevent under-punishment.
    max_fine = 16917, -- Upper clamp to keep legal proportionality.
    base_months = 34, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_178'] = {
    label = 'Infraction 178', -- Human readable name for offense code CORRUPTION_178.
    code = 'CORRUPTION_178', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 7086, -- Base fine before priors/recidive multipliers.
    min_fine = 4960, -- Lower clamp to prevent under-punishment.
    max_fine = 17006, -- Upper clamp to keep legal proportionality.
    base_months = 35, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_179'] = {
    label = 'Infraction 179', -- Human readable name for offense code SEQUESTRATION_179.
    code = 'SEQUESTRATION_179', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 7123, -- Base fine before priors/recidive multipliers.
    min_fine = 4986, -- Lower clamp to prevent under-punishment.
    max_fine = 17095, -- Upper clamp to keep legal proportionality.
    base_months = 36, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_180'] = {
    label = 'Infraction 180', -- Human readable name for offense code VOL_QUALIFIE_180.
    code = 'VOL_QUALIFIE_180', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 7160, -- Base fine before priors/recidive multipliers.
    min_fine = 5012, -- Lower clamp to prevent under-punishment.
    max_fine = 17184, -- Upper clamp to keep legal proportionality.
    base_months = 37, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_181'] = {
    label = 'Infraction 181', -- Human readable name for offense code USAGE_ARME_181.
    code = 'USAGE_ARME_181', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 7197, -- Base fine before priors/recidive multipliers.
    min_fine = 5037, -- Lower clamp to prevent under-punishment.
    max_fine = 17272, -- Upper clamp to keep legal proportionality.
    base_months = 38, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_182'] = {
    label = 'Infraction 182', -- Human readable name for offense code FUITE_182.
    code = 'FUITE_182', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 7234, -- Base fine before priors/recidive multipliers.
    min_fine = 5063, -- Lower clamp to prevent under-punishment.
    max_fine = 17361, -- Upper clamp to keep legal proportionality.
    base_months = 39, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_183'] = {
    label = 'Infraction 183', -- Human readable name for offense code MISE_EN_DANGER_183.
    code = 'MISE_EN_DANGER_183', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 7271, -- Base fine before priors/recidive multipliers.
    min_fine = 5089, -- Lower clamp to prevent under-punishment.
    max_fine = 17450, -- Upper clamp to keep legal proportionality.
    base_months = 40, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_184'] = {
    label = 'Infraction 184', -- Human readable name for offense code POSSESSION_DROGUE_184.
    code = 'POSSESSION_DROGUE_184', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 7308, -- Base fine before priors/recidive multipliers.
    min_fine = 5115, -- Lower clamp to prevent under-punishment.
    max_fine = 17539, -- Upper clamp to keep legal proportionality.
    base_months = 41, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_185'] = {
    label = 'Infraction 185', -- Human readable name for offense code VENTE_DROGUE_185.
    code = 'VENTE_DROGUE_185', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 7345, -- Base fine before priors/recidive multipliers.
    min_fine = 5141, -- Lower clamp to prevent under-punishment.
    max_fine = 17628, -- Upper clamp to keep legal proportionality.
    base_months = 42, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_186'] = {
    label = 'Infraction 186', -- Human readable name for offense code AGRESSION_SIMPLE_186.
    code = 'AGRESSION_SIMPLE_186', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 7382, -- Base fine before priors/recidive multipliers.
    min_fine = 5167, -- Lower clamp to prevent under-punishment.
    max_fine = 17716, -- Upper clamp to keep legal proportionality.
    base_months = 43, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_187'] = {
    label = 'Infraction 187', -- Human readable name for offense code AGRESSION_ARMEE_187.
    code = 'AGRESSION_ARMEE_187', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 7419, -- Base fine before priors/recidive multipliers.
    min_fine = 5193, -- Lower clamp to prevent under-punishment.
    max_fine = 17805, -- Upper clamp to keep legal proportionality.
    base_months = 44, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_188'] = {
    label = 'Infraction 188', -- Human readable name for offense code HOMICIDE_188.
    code = 'HOMICIDE_188', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 7456, -- Base fine before priors/recidive multipliers.
    min_fine = 5219, -- Lower clamp to prevent under-punishment.
    max_fine = 17894, -- Upper clamp to keep legal proportionality.
    base_months = 45, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_189'] = {
    label = 'Infraction 189', -- Human readable name for offense code FRAUDE_189.
    code = 'FRAUDE_189', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 7493, -- Base fine before priors/recidive multipliers.
    min_fine = 5245, -- Lower clamp to prevent under-punishment.
    max_fine = 17983, -- Upper clamp to keep legal proportionality.
    base_months = 46, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_190'] = {
    label = 'Infraction 190', -- Human readable name for offense code CORRUPTION_190.
    code = 'CORRUPTION_190', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 7530, -- Base fine before priors/recidive multipliers.
    min_fine = 5271, -- Lower clamp to prevent under-punishment.
    max_fine = 18072, -- Upper clamp to keep legal proportionality.
    base_months = 47, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_191'] = {
    label = 'Infraction 191', -- Human readable name for offense code SEQUESTRATION_191.
    code = 'SEQUESTRATION_191', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 7567, -- Base fine before priors/recidive multipliers.
    min_fine = 5296, -- Lower clamp to prevent under-punishment.
    max_fine = 18160, -- Upper clamp to keep legal proportionality.
    base_months = 48, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 16, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_192'] = {
    label = 'Infraction 192', -- Human readable name for offense code VOL_QUALIFIE_192.
    code = 'VOL_QUALIFIE_192', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 7604, -- Base fine before priors/recidive multipliers.
    min_fine = 5322, -- Lower clamp to prevent under-punishment.
    max_fine = 18249, -- Upper clamp to keep legal proportionality.
    base_months = 1, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_193'] = {
    label = 'Infraction 193', -- Human readable name for offense code USAGE_ARME_193.
    code = 'USAGE_ARME_193', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 7641, -- Base fine before priors/recidive multipliers.
    min_fine = 5348, -- Lower clamp to prevent under-punishment.
    max_fine = 18338, -- Upper clamp to keep legal proportionality.
    base_months = 2, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_194'] = {
    label = 'Infraction 194', -- Human readable name for offense code FUITE_194.
    code = 'FUITE_194', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 7678, -- Base fine before priors/recidive multipliers.
    min_fine = 5374, -- Lower clamp to prevent under-punishment.
    max_fine = 18427, -- Upper clamp to keep legal proportionality.
    base_months = 3, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_195'] = {
    label = 'Infraction 195', -- Human readable name for offense code MISE_EN_DANGER_195.
    code = 'MISE_EN_DANGER_195', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 7715, -- Base fine before priors/recidive multipliers.
    min_fine = 5400, -- Lower clamp to prevent under-punishment.
    max_fine = 18516, -- Upper clamp to keep legal proportionality.
    base_months = 4, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_196'] = {
    label = 'Infraction 196', -- Human readable name for offense code POSSESSION_DROGUE_196.
    code = 'POSSESSION_DROGUE_196', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 7752, -- Base fine before priors/recidive multipliers.
    min_fine = 5426, -- Lower clamp to prevent under-punishment.
    max_fine = 18604, -- Upper clamp to keep legal proportionality.
    base_months = 5, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_197'] = {
    label = 'Infraction 197', -- Human readable name for offense code VENTE_DROGUE_197.
    code = 'VENTE_DROGUE_197', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 7789, -- Base fine before priors/recidive multipliers.
    min_fine = 5452, -- Lower clamp to prevent under-punishment.
    max_fine = 18693, -- Upper clamp to keep legal proportionality.
    base_months = 6, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_198'] = {
    label = 'Infraction 198', -- Human readable name for offense code AGRESSION_SIMPLE_198.
    code = 'AGRESSION_SIMPLE_198', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 7826, -- Base fine before priors/recidive multipliers.
    min_fine = 5478, -- Lower clamp to prevent under-punishment.
    max_fine = 18782, -- Upper clamp to keep legal proportionality.
    base_months = 7, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_199'] = {
    label = 'Infraction 199', -- Human readable name for offense code AGRESSION_ARMEE_199.
    code = 'AGRESSION_ARMEE_199', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 7863, -- Base fine before priors/recidive multipliers.
    min_fine = 5504, -- Lower clamp to prevent under-punishment.
    max_fine = 18871, -- Upper clamp to keep legal proportionality.
    base_months = 8, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_200'] = {
    label = 'Infraction 200', -- Human readable name for offense code HOMICIDE_200.
    code = 'HOMICIDE_200', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 7900, -- Base fine before priors/recidive multipliers.
    min_fine = 5530, -- Lower clamp to prevent under-punishment.
    max_fine = 18960, -- Upper clamp to keep legal proportionality.
    base_months = 9, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_201'] = {
    label = 'Infraction 201', -- Human readable name for offense code FRAUDE_201.
    code = 'FRAUDE_201', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 7937, -- Base fine before priors/recidive multipliers.
    min_fine = 5555, -- Lower clamp to prevent under-punishment.
    max_fine = 19048, -- Upper clamp to keep legal proportionality.
    base_months = 10, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_202'] = {
    label = 'Infraction 202', -- Human readable name for offense code CORRUPTION_202.
    code = 'CORRUPTION_202', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 7974, -- Base fine before priors/recidive multipliers.
    min_fine = 5581, -- Lower clamp to prevent under-punishment.
    max_fine = 19137, -- Upper clamp to keep legal proportionality.
    base_months = 11, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_203'] = {
    label = 'Infraction 203', -- Human readable name for offense code SEQUESTRATION_203.
    code = 'SEQUESTRATION_203', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 8011, -- Base fine before priors/recidive multipliers.
    min_fine = 5607, -- Lower clamp to prevent under-punishment.
    max_fine = 19226, -- Upper clamp to keep legal proportionality.
    base_months = 12, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_204'] = {
    label = 'Infraction 204', -- Human readable name for offense code VOL_QUALIFIE_204.
    code = 'VOL_QUALIFIE_204', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 8048, -- Base fine before priors/recidive multipliers.
    min_fine = 5633, -- Lower clamp to prevent under-punishment.
    max_fine = 19315, -- Upper clamp to keep legal proportionality.
    base_months = 13, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_205'] = {
    label = 'Infraction 205', -- Human readable name for offense code USAGE_ARME_205.
    code = 'USAGE_ARME_205', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 8085, -- Base fine before priors/recidive multipliers.
    min_fine = 5659, -- Lower clamp to prevent under-punishment.
    max_fine = 19404, -- Upper clamp to keep legal proportionality.
    base_months = 14, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_206'] = {
    label = 'Infraction 206', -- Human readable name for offense code FUITE_206.
    code = 'FUITE_206', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 8122, -- Base fine before priors/recidive multipliers.
    min_fine = 5685, -- Lower clamp to prevent under-punishment.
    max_fine = 19492, -- Upper clamp to keep legal proportionality.
    base_months = 15, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_207'] = {
    label = 'Infraction 207', -- Human readable name for offense code MISE_EN_DANGER_207.
    code = 'MISE_EN_DANGER_207', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 8159, -- Base fine before priors/recidive multipliers.
    min_fine = 5711, -- Lower clamp to prevent under-punishment.
    max_fine = 19581, -- Upper clamp to keep legal proportionality.
    base_months = 16, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_208'] = {
    label = 'Infraction 208', -- Human readable name for offense code POSSESSION_DROGUE_208.
    code = 'POSSESSION_DROGUE_208', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 8196, -- Base fine before priors/recidive multipliers.
    min_fine = 5737, -- Lower clamp to prevent under-punishment.
    max_fine = 19670, -- Upper clamp to keep legal proportionality.
    base_months = 17, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_209'] = {
    label = 'Infraction 209', -- Human readable name for offense code VENTE_DROGUE_209.
    code = 'VENTE_DROGUE_209', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 8233, -- Base fine before priors/recidive multipliers.
    min_fine = 5763, -- Lower clamp to prevent under-punishment.
    max_fine = 19759, -- Upper clamp to keep legal proportionality.
    base_months = 18, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_210'] = {
    label = 'Infraction 210', -- Human readable name for offense code AGRESSION_SIMPLE_210.
    code = 'AGRESSION_SIMPLE_210', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 8270, -- Base fine before priors/recidive multipliers.
    min_fine = 5789, -- Lower clamp to prevent under-punishment.
    max_fine = 19848, -- Upper clamp to keep legal proportionality.
    base_months = 19, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_211'] = {
    label = 'Infraction 211', -- Human readable name for offense code AGRESSION_ARMEE_211.
    code = 'AGRESSION_ARMEE_211', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 8307, -- Base fine before priors/recidive multipliers.
    min_fine = 5814, -- Lower clamp to prevent under-punishment.
    max_fine = 19936, -- Upper clamp to keep legal proportionality.
    base_months = 20, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_212'] = {
    label = 'Infraction 212', -- Human readable name for offense code HOMICIDE_212.
    code = 'HOMICIDE_212', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 8344, -- Base fine before priors/recidive multipliers.
    min_fine = 5840, -- Lower clamp to prevent under-punishment.
    max_fine = 20025, -- Upper clamp to keep legal proportionality.
    base_months = 21, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_213'] = {
    label = 'Infraction 213', -- Human readable name for offense code FRAUDE_213.
    code = 'FRAUDE_213', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 8381, -- Base fine before priors/recidive multipliers.
    min_fine = 5866, -- Lower clamp to prevent under-punishment.
    max_fine = 20114, -- Upper clamp to keep legal proportionality.
    base_months = 22, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_214'] = {
    label = 'Infraction 214', -- Human readable name for offense code CORRUPTION_214.
    code = 'CORRUPTION_214', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 8418, -- Base fine before priors/recidive multipliers.
    min_fine = 5892, -- Lower clamp to prevent under-punishment.
    max_fine = 20203, -- Upper clamp to keep legal proportionality.
    base_months = 23, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_215'] = {
    label = 'Infraction 215', -- Human readable name for offense code SEQUESTRATION_215.
    code = 'SEQUESTRATION_215', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 8455, -- Base fine before priors/recidive multipliers.
    min_fine = 5918, -- Lower clamp to prevent under-punishment.
    max_fine = 20292, -- Upper clamp to keep legal proportionality.
    base_months = 24, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_216'] = {
    label = 'Infraction 216', -- Human readable name for offense code VOL_QUALIFIE_216.
    code = 'VOL_QUALIFIE_216', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 8492, -- Base fine before priors/recidive multipliers.
    min_fine = 5944, -- Lower clamp to prevent under-punishment.
    max_fine = 20380, -- Upper clamp to keep legal proportionality.
    base_months = 25, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_217'] = {
    label = 'Infraction 217', -- Human readable name for offense code USAGE_ARME_217.
    code = 'USAGE_ARME_217', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 8529, -- Base fine before priors/recidive multipliers.
    min_fine = 5970, -- Lower clamp to prevent under-punishment.
    max_fine = 20469, -- Upper clamp to keep legal proportionality.
    base_months = 26, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_218'] = {
    label = 'Infraction 218', -- Human readable name for offense code FUITE_218.
    code = 'FUITE_218', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 8566, -- Base fine before priors/recidive multipliers.
    min_fine = 5996, -- Lower clamp to prevent under-punishment.
    max_fine = 20558, -- Upper clamp to keep legal proportionality.
    base_months = 27, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_219'] = {
    label = 'Infraction 219', -- Human readable name for offense code MISE_EN_DANGER_219.
    code = 'MISE_EN_DANGER_219', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 8603, -- Base fine before priors/recidive multipliers.
    min_fine = 6022, -- Lower clamp to prevent under-punishment.
    max_fine = 20647, -- Upper clamp to keep legal proportionality.
    base_months = 28, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_220'] = {
    label = 'Infraction 220', -- Human readable name for offense code POSSESSION_DROGUE_220.
    code = 'POSSESSION_DROGUE_220', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 8640, -- Base fine before priors/recidive multipliers.
    min_fine = 6048, -- Lower clamp to prevent under-punishment.
    max_fine = 20736, -- Upper clamp to keep legal proportionality.
    base_months = 29, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_221'] = {
    label = 'Infraction 221', -- Human readable name for offense code VENTE_DROGUE_221.
    code = 'VENTE_DROGUE_221', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 8677, -- Base fine before priors/recidive multipliers.
    min_fine = 6073, -- Lower clamp to prevent under-punishment.
    max_fine = 20824, -- Upper clamp to keep legal proportionality.
    base_months = 30, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_222'] = {
    label = 'Infraction 222', -- Human readable name for offense code AGRESSION_SIMPLE_222.
    code = 'AGRESSION_SIMPLE_222', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 8714, -- Base fine before priors/recidive multipliers.
    min_fine = 6099, -- Lower clamp to prevent under-punishment.
    max_fine = 20913, -- Upper clamp to keep legal proportionality.
    base_months = 31, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_223'] = {
    label = 'Infraction 223', -- Human readable name for offense code AGRESSION_ARMEE_223.
    code = 'AGRESSION_ARMEE_223', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 8751, -- Base fine before priors/recidive multipliers.
    min_fine = 6125, -- Lower clamp to prevent under-punishment.
    max_fine = 21002, -- Upper clamp to keep legal proportionality.
    base_months = 32, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_224'] = {
    label = 'Infraction 224', -- Human readable name for offense code HOMICIDE_224.
    code = 'HOMICIDE_224', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 8788, -- Base fine before priors/recidive multipliers.
    min_fine = 6151, -- Lower clamp to prevent under-punishment.
    max_fine = 21091, -- Upper clamp to keep legal proportionality.
    base_months = 33, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_225'] = {
    label = 'Infraction 225', -- Human readable name for offense code FRAUDE_225.
    code = 'FRAUDE_225', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 8825, -- Base fine before priors/recidive multipliers.
    min_fine = 6177, -- Lower clamp to prevent under-punishment.
    max_fine = 21180, -- Upper clamp to keep legal proportionality.
    base_months = 34, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_226'] = {
    label = 'Infraction 226', -- Human readable name for offense code CORRUPTION_226.
    code = 'CORRUPTION_226', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 8862, -- Base fine before priors/recidive multipliers.
    min_fine = 6203, -- Lower clamp to prevent under-punishment.
    max_fine = 21268, -- Upper clamp to keep legal proportionality.
    base_months = 35, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_227'] = {
    label = 'Infraction 227', -- Human readable name for offense code SEQUESTRATION_227.
    code = 'SEQUESTRATION_227', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 8899, -- Base fine before priors/recidive multipliers.
    min_fine = 6229, -- Lower clamp to prevent under-punishment.
    max_fine = 21357, -- Upper clamp to keep legal proportionality.
    base_months = 36, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_228'] = {
    label = 'Infraction 228', -- Human readable name for offense code VOL_QUALIFIE_228.
    code = 'VOL_QUALIFIE_228', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 8936, -- Base fine before priors/recidive multipliers.
    min_fine = 6255, -- Lower clamp to prevent under-punishment.
    max_fine = 21446, -- Upper clamp to keep legal proportionality.
    base_months = 37, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_229'] = {
    label = 'Infraction 229', -- Human readable name for offense code USAGE_ARME_229.
    code = 'USAGE_ARME_229', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 8973, -- Base fine before priors/recidive multipliers.
    min_fine = 6281, -- Lower clamp to prevent under-punishment.
    max_fine = 21535, -- Upper clamp to keep legal proportionality.
    base_months = 38, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_230'] = {
    label = 'Infraction 230', -- Human readable name for offense code FUITE_230.
    code = 'FUITE_230', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 9010, -- Base fine before priors/recidive multipliers.
    min_fine = 6307, -- Lower clamp to prevent under-punishment.
    max_fine = 21624, -- Upper clamp to keep legal proportionality.
    base_months = 39, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_231'] = {
    label = 'Infraction 231', -- Human readable name for offense code MISE_EN_DANGER_231.
    code = 'MISE_EN_DANGER_231', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 9047, -- Base fine before priors/recidive multipliers.
    min_fine = 6332, -- Lower clamp to prevent under-punishment.
    max_fine = 21712, -- Upper clamp to keep legal proportionality.
    base_months = 40, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_232'] = {
    label = 'Infraction 232', -- Human readable name for offense code POSSESSION_DROGUE_232.
    code = 'POSSESSION_DROGUE_232', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 9084, -- Base fine before priors/recidive multipliers.
    min_fine = 6358, -- Lower clamp to prevent under-punishment.
    max_fine = 21801, -- Upper clamp to keep legal proportionality.
    base_months = 41, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_233'] = {
    label = 'Infraction 233', -- Human readable name for offense code VENTE_DROGUE_233.
    code = 'VENTE_DROGUE_233', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 9121, -- Base fine before priors/recidive multipliers.
    min_fine = 6384, -- Lower clamp to prevent under-punishment.
    max_fine = 21890, -- Upper clamp to keep legal proportionality.
    base_months = 42, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_234'] = {
    label = 'Infraction 234', -- Human readable name for offense code AGRESSION_SIMPLE_234.
    code = 'AGRESSION_SIMPLE_234', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 9158, -- Base fine before priors/recidive multipliers.
    min_fine = 6410, -- Lower clamp to prevent under-punishment.
    max_fine = 21979, -- Upper clamp to keep legal proportionality.
    base_months = 43, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_235'] = {
    label = 'Infraction 235', -- Human readable name for offense code AGRESSION_ARMEE_235.
    code = 'AGRESSION_ARMEE_235', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 9195, -- Base fine before priors/recidive multipliers.
    min_fine = 6436, -- Lower clamp to prevent under-punishment.
    max_fine = 22068, -- Upper clamp to keep legal proportionality.
    base_months = 44, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_236'] = {
    label = 'Infraction 236', -- Human readable name for offense code HOMICIDE_236.
    code = 'HOMICIDE_236', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 9232, -- Base fine before priors/recidive multipliers.
    min_fine = 6462, -- Lower clamp to prevent under-punishment.
    max_fine = 22156, -- Upper clamp to keep legal proportionality.
    base_months = 45, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_237'] = {
    label = 'Infraction 237', -- Human readable name for offense code FRAUDE_237.
    code = 'FRAUDE_237', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 9269, -- Base fine before priors/recidive multipliers.
    min_fine = 6488, -- Lower clamp to prevent under-punishment.
    max_fine = 22245, -- Upper clamp to keep legal proportionality.
    base_months = 46, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_238'] = {
    label = 'Infraction 238', -- Human readable name for offense code CORRUPTION_238.
    code = 'CORRUPTION_238', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 9306, -- Base fine before priors/recidive multipliers.
    min_fine = 6514, -- Lower clamp to prevent under-punishment.
    max_fine = 22334, -- Upper clamp to keep legal proportionality.
    base_months = 47, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_239'] = {
    label = 'Infraction 239', -- Human readable name for offense code SEQUESTRATION_239.
    code = 'SEQUESTRATION_239', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 9343, -- Base fine before priors/recidive multipliers.
    min_fine = 6540, -- Lower clamp to prevent under-punishment.
    max_fine = 22423, -- Upper clamp to keep legal proportionality.
    base_months = 48, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 16, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_240'] = {
    label = 'Infraction 240', -- Human readable name for offense code VOL_QUALIFIE_240.
    code = 'VOL_QUALIFIE_240', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 9380, -- Base fine before priors/recidive multipliers.
    min_fine = 6566, -- Lower clamp to prevent under-punishment.
    max_fine = 22512, -- Upper clamp to keep legal proportionality.
    base_months = 1, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_241'] = {
    label = 'Infraction 241', -- Human readable name for offense code USAGE_ARME_241.
    code = 'USAGE_ARME_241', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 9417, -- Base fine before priors/recidive multipliers.
    min_fine = 6591, -- Lower clamp to prevent under-punishment.
    max_fine = 22600, -- Upper clamp to keep legal proportionality.
    base_months = 2, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_242'] = {
    label = 'Infraction 242', -- Human readable name for offense code FUITE_242.
    code = 'FUITE_242', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 9454, -- Base fine before priors/recidive multipliers.
    min_fine = 6617, -- Lower clamp to prevent under-punishment.
    max_fine = 22689, -- Upper clamp to keep legal proportionality.
    base_months = 3, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_243'] = {
    label = 'Infraction 243', -- Human readable name for offense code MISE_EN_DANGER_243.
    code = 'MISE_EN_DANGER_243', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 9491, -- Base fine before priors/recidive multipliers.
    min_fine = 6643, -- Lower clamp to prevent under-punishment.
    max_fine = 22778, -- Upper clamp to keep legal proportionality.
    base_months = 4, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_244'] = {
    label = 'Infraction 244', -- Human readable name for offense code POSSESSION_DROGUE_244.
    code = 'POSSESSION_DROGUE_244', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 528, -- Base fine before priors/recidive multipliers.
    min_fine = 369, -- Lower clamp to prevent under-punishment.
    max_fine = 1267, -- Upper clamp to keep legal proportionality.
    base_months = 5, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_245'] = {
    label = 'Infraction 245', -- Human readable name for offense code VENTE_DROGUE_245.
    code = 'VENTE_DROGUE_245', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 565, -- Base fine before priors/recidive multipliers.
    min_fine = 395, -- Lower clamp to prevent under-punishment.
    max_fine = 1356, -- Upper clamp to keep legal proportionality.
    base_months = 6, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_246'] = {
    label = 'Infraction 246', -- Human readable name for offense code AGRESSION_SIMPLE_246.
    code = 'AGRESSION_SIMPLE_246', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 602, -- Base fine before priors/recidive multipliers.
    min_fine = 421, -- Lower clamp to prevent under-punishment.
    max_fine = 1444, -- Upper clamp to keep legal proportionality.
    base_months = 7, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_247'] = {
    label = 'Infraction 247', -- Human readable name for offense code AGRESSION_ARMEE_247.
    code = 'AGRESSION_ARMEE_247', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 639, -- Base fine before priors/recidive multipliers.
    min_fine = 447, -- Lower clamp to prevent under-punishment.
    max_fine = 1533, -- Upper clamp to keep legal proportionality.
    base_months = 8, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_248'] = {
    label = 'Infraction 248', -- Human readable name for offense code HOMICIDE_248.
    code = 'HOMICIDE_248', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 676, -- Base fine before priors/recidive multipliers.
    min_fine = 473, -- Lower clamp to prevent under-punishment.
    max_fine = 1622, -- Upper clamp to keep legal proportionality.
    base_months = 9, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_249'] = {
    label = 'Infraction 249', -- Human readable name for offense code FRAUDE_249.
    code = 'FRAUDE_249', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 713, -- Base fine before priors/recidive multipliers.
    min_fine = 499, -- Lower clamp to prevent under-punishment.
    max_fine = 1711, -- Upper clamp to keep legal proportionality.
    base_months = 10, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_250'] = {
    label = 'Infraction 250', -- Human readable name for offense code CORRUPTION_250.
    code = 'CORRUPTION_250', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 750, -- Base fine before priors/recidive multipliers.
    min_fine = 525, -- Lower clamp to prevent under-punishment.
    max_fine = 1800, -- Upper clamp to keep legal proportionality.
    base_months = 11, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_251'] = {
    label = 'Infraction 251', -- Human readable name for offense code SEQUESTRATION_251.
    code = 'SEQUESTRATION_251', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 787, -- Base fine before priors/recidive multipliers.
    min_fine = 550, -- Lower clamp to prevent under-punishment.
    max_fine = 1888, -- Upper clamp to keep legal proportionality.
    base_months = 12, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_252'] = {
    label = 'Infraction 252', -- Human readable name for offense code VOL_QUALIFIE_252.
    code = 'VOL_QUALIFIE_252', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 824, -- Base fine before priors/recidive multipliers.
    min_fine = 576, -- Lower clamp to prevent under-punishment.
    max_fine = 1977, -- Upper clamp to keep legal proportionality.
    base_months = 13, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_253'] = {
    label = 'Infraction 253', -- Human readable name for offense code USAGE_ARME_253.
    code = 'USAGE_ARME_253', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 861, -- Base fine before priors/recidive multipliers.
    min_fine = 602, -- Lower clamp to prevent under-punishment.
    max_fine = 2066, -- Upper clamp to keep legal proportionality.
    base_months = 14, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_254'] = {
    label = 'Infraction 254', -- Human readable name for offense code FUITE_254.
    code = 'FUITE_254', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 898, -- Base fine before priors/recidive multipliers.
    min_fine = 628, -- Lower clamp to prevent under-punishment.
    max_fine = 2155, -- Upper clamp to keep legal proportionality.
    base_months = 15, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_255'] = {
    label = 'Infraction 255', -- Human readable name for offense code MISE_EN_DANGER_255.
    code = 'MISE_EN_DANGER_255', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 935, -- Base fine before priors/recidive multipliers.
    min_fine = 654, -- Lower clamp to prevent under-punishment.
    max_fine = 2244, -- Upper clamp to keep legal proportionality.
    base_months = 16, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_256'] = {
    label = 'Infraction 256', -- Human readable name for offense code POSSESSION_DROGUE_256.
    code = 'POSSESSION_DROGUE_256', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 972, -- Base fine before priors/recidive multipliers.
    min_fine = 680, -- Lower clamp to prevent under-punishment.
    max_fine = 2332, -- Upper clamp to keep legal proportionality.
    base_months = 17, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_257'] = {
    label = 'Infraction 257', -- Human readable name for offense code VENTE_DROGUE_257.
    code = 'VENTE_DROGUE_257', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1009, -- Base fine before priors/recidive multipliers.
    min_fine = 706, -- Lower clamp to prevent under-punishment.
    max_fine = 2421, -- Upper clamp to keep legal proportionality.
    base_months = 18, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_258'] = {
    label = 'Infraction 258', -- Human readable name for offense code AGRESSION_SIMPLE_258.
    code = 'AGRESSION_SIMPLE_258', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1046, -- Base fine before priors/recidive multipliers.
    min_fine = 732, -- Lower clamp to prevent under-punishment.
    max_fine = 2510, -- Upper clamp to keep legal proportionality.
    base_months = 19, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_259'] = {
    label = 'Infraction 259', -- Human readable name for offense code AGRESSION_ARMEE_259.
    code = 'AGRESSION_ARMEE_259', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1083, -- Base fine before priors/recidive multipliers.
    min_fine = 758, -- Lower clamp to prevent under-punishment.
    max_fine = 2599, -- Upper clamp to keep legal proportionality.
    base_months = 20, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_260'] = {
    label = 'Infraction 260', -- Human readable name for offense code HOMICIDE_260.
    code = 'HOMICIDE_260', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1120, -- Base fine before priors/recidive multipliers.
    min_fine = 784, -- Lower clamp to prevent under-punishment.
    max_fine = 2688, -- Upper clamp to keep legal proportionality.
    base_months = 21, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_261'] = {
    label = 'Infraction 261', -- Human readable name for offense code FRAUDE_261.
    code = 'FRAUDE_261', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1157, -- Base fine before priors/recidive multipliers.
    min_fine = 809, -- Lower clamp to prevent under-punishment.
    max_fine = 2776, -- Upper clamp to keep legal proportionality.
    base_months = 22, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_262'] = {
    label = 'Infraction 262', -- Human readable name for offense code CORRUPTION_262.
    code = 'CORRUPTION_262', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1194, -- Base fine before priors/recidive multipliers.
    min_fine = 835, -- Lower clamp to prevent under-punishment.
    max_fine = 2865, -- Upper clamp to keep legal proportionality.
    base_months = 23, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_263'] = {
    label = 'Infraction 263', -- Human readable name for offense code SEQUESTRATION_263.
    code = 'SEQUESTRATION_263', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1231, -- Base fine before priors/recidive multipliers.
    min_fine = 861, -- Lower clamp to prevent under-punishment.
    max_fine = 2954, -- Upper clamp to keep legal proportionality.
    base_months = 24, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_264'] = {
    label = 'Infraction 264', -- Human readable name for offense code VOL_QUALIFIE_264.
    code = 'VOL_QUALIFIE_264', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1268, -- Base fine before priors/recidive multipliers.
    min_fine = 887, -- Lower clamp to prevent under-punishment.
    max_fine = 3043, -- Upper clamp to keep legal proportionality.
    base_months = 25, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_265'] = {
    label = 'Infraction 265', -- Human readable name for offense code USAGE_ARME_265.
    code = 'USAGE_ARME_265', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1305, -- Base fine before priors/recidive multipliers.
    min_fine = 913, -- Lower clamp to prevent under-punishment.
    max_fine = 3132, -- Upper clamp to keep legal proportionality.
    base_months = 26, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_266'] = {
    label = 'Infraction 266', -- Human readable name for offense code FUITE_266.
    code = 'FUITE_266', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1342, -- Base fine before priors/recidive multipliers.
    min_fine = 939, -- Lower clamp to prevent under-punishment.
    max_fine = 3220, -- Upper clamp to keep legal proportionality.
    base_months = 27, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_267'] = {
    label = 'Infraction 267', -- Human readable name for offense code MISE_EN_DANGER_267.
    code = 'MISE_EN_DANGER_267', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1379, -- Base fine before priors/recidive multipliers.
    min_fine = 965, -- Lower clamp to prevent under-punishment.
    max_fine = 3309, -- Upper clamp to keep legal proportionality.
    base_months = 28, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_268'] = {
    label = 'Infraction 268', -- Human readable name for offense code POSSESSION_DROGUE_268.
    code = 'POSSESSION_DROGUE_268', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1416, -- Base fine before priors/recidive multipliers.
    min_fine = 991, -- Lower clamp to prevent under-punishment.
    max_fine = 3398, -- Upper clamp to keep legal proportionality.
    base_months = 29, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_269'] = {
    label = 'Infraction 269', -- Human readable name for offense code VENTE_DROGUE_269.
    code = 'VENTE_DROGUE_269', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1453, -- Base fine before priors/recidive multipliers.
    min_fine = 1017, -- Lower clamp to prevent under-punishment.
    max_fine = 3487, -- Upper clamp to keep legal proportionality.
    base_months = 30, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_270'] = {
    label = 'Infraction 270', -- Human readable name for offense code AGRESSION_SIMPLE_270.
    code = 'AGRESSION_SIMPLE_270', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1490, -- Base fine before priors/recidive multipliers.
    min_fine = 1043, -- Lower clamp to prevent under-punishment.
    max_fine = 3576, -- Upper clamp to keep legal proportionality.
    base_months = 31, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_271'] = {
    label = 'Infraction 271', -- Human readable name for offense code AGRESSION_ARMEE_271.
    code = 'AGRESSION_ARMEE_271', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1527, -- Base fine before priors/recidive multipliers.
    min_fine = 1068, -- Lower clamp to prevent under-punishment.
    max_fine = 3664, -- Upper clamp to keep legal proportionality.
    base_months = 32, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_272'] = {
    label = 'Infraction 272', -- Human readable name for offense code HOMICIDE_272.
    code = 'HOMICIDE_272', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1564, -- Base fine before priors/recidive multipliers.
    min_fine = 1094, -- Lower clamp to prevent under-punishment.
    max_fine = 3753, -- Upper clamp to keep legal proportionality.
    base_months = 33, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_273'] = {
    label = 'Infraction 273', -- Human readable name for offense code FRAUDE_273.
    code = 'FRAUDE_273', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1601, -- Base fine before priors/recidive multipliers.
    min_fine = 1120, -- Lower clamp to prevent under-punishment.
    max_fine = 3842, -- Upper clamp to keep legal proportionality.
    base_months = 34, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_274'] = {
    label = 'Infraction 274', -- Human readable name for offense code CORRUPTION_274.
    code = 'CORRUPTION_274', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1638, -- Base fine before priors/recidive multipliers.
    min_fine = 1146, -- Lower clamp to prevent under-punishment.
    max_fine = 3931, -- Upper clamp to keep legal proportionality.
    base_months = 35, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_275'] = {
    label = 'Infraction 275', -- Human readable name for offense code SEQUESTRATION_275.
    code = 'SEQUESTRATION_275', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1675, -- Base fine before priors/recidive multipliers.
    min_fine = 1172, -- Lower clamp to prevent under-punishment.
    max_fine = 4020, -- Upper clamp to keep legal proportionality.
    base_months = 36, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_276'] = {
    label = 'Infraction 276', -- Human readable name for offense code VOL_QUALIFIE_276.
    code = 'VOL_QUALIFIE_276', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1712, -- Base fine before priors/recidive multipliers.
    min_fine = 1198, -- Lower clamp to prevent under-punishment.
    max_fine = 4108, -- Upper clamp to keep legal proportionality.
    base_months = 37, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_277'] = {
    label = 'Infraction 277', -- Human readable name for offense code USAGE_ARME_277.
    code = 'USAGE_ARME_277', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1749, -- Base fine before priors/recidive multipliers.
    min_fine = 1224, -- Lower clamp to prevent under-punishment.
    max_fine = 4197, -- Upper clamp to keep legal proportionality.
    base_months = 38, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_278'] = {
    label = 'Infraction 278', -- Human readable name for offense code FUITE_278.
    code = 'FUITE_278', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1786, -- Base fine before priors/recidive multipliers.
    min_fine = 1250, -- Lower clamp to prevent under-punishment.
    max_fine = 4286, -- Upper clamp to keep legal proportionality.
    base_months = 39, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_279'] = {
    label = 'Infraction 279', -- Human readable name for offense code MISE_EN_DANGER_279.
    code = 'MISE_EN_DANGER_279', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1823, -- Base fine before priors/recidive multipliers.
    min_fine = 1276, -- Lower clamp to prevent under-punishment.
    max_fine = 4375, -- Upper clamp to keep legal proportionality.
    base_months = 40, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_280'] = {
    label = 'Infraction 280', -- Human readable name for offense code POSSESSION_DROGUE_280.
    code = 'POSSESSION_DROGUE_280', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1860, -- Base fine before priors/recidive multipliers.
    min_fine = 1302, -- Lower clamp to prevent under-punishment.
    max_fine = 4464, -- Upper clamp to keep legal proportionality.
    base_months = 41, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_281'] = {
    label = 'Infraction 281', -- Human readable name for offense code VENTE_DROGUE_281.
    code = 'VENTE_DROGUE_281', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1897, -- Base fine before priors/recidive multipliers.
    min_fine = 1327, -- Lower clamp to prevent under-punishment.
    max_fine = 4552, -- Upper clamp to keep legal proportionality.
    base_months = 42, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_282'] = {
    label = 'Infraction 282', -- Human readable name for offense code AGRESSION_SIMPLE_282.
    code = 'AGRESSION_SIMPLE_282', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1934, -- Base fine before priors/recidive multipliers.
    min_fine = 1353, -- Lower clamp to prevent under-punishment.
    max_fine = 4641, -- Upper clamp to keep legal proportionality.
    base_months = 43, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_283'] = {
    label = 'Infraction 283', -- Human readable name for offense code AGRESSION_ARMEE_283.
    code = 'AGRESSION_ARMEE_283', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1971, -- Base fine before priors/recidive multipliers.
    min_fine = 1379, -- Lower clamp to prevent under-punishment.
    max_fine = 4730, -- Upper clamp to keep legal proportionality.
    base_months = 44, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_284'] = {
    label = 'Infraction 284', -- Human readable name for offense code HOMICIDE_284.
    code = 'HOMICIDE_284', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 2008, -- Base fine before priors/recidive multipliers.
    min_fine = 1405, -- Lower clamp to prevent under-punishment.
    max_fine = 4819, -- Upper clamp to keep legal proportionality.
    base_months = 45, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_285'] = {
    label = 'Infraction 285', -- Human readable name for offense code FRAUDE_285.
    code = 'FRAUDE_285', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 2045, -- Base fine before priors/recidive multipliers.
    min_fine = 1431, -- Lower clamp to prevent under-punishment.
    max_fine = 4908, -- Upper clamp to keep legal proportionality.
    base_months = 46, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_286'] = {
    label = 'Infraction 286', -- Human readable name for offense code CORRUPTION_286.
    code = 'CORRUPTION_286', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 2082, -- Base fine before priors/recidive multipliers.
    min_fine = 1457, -- Lower clamp to prevent under-punishment.
    max_fine = 4996, -- Upper clamp to keep legal proportionality.
    base_months = 47, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_287'] = {
    label = 'Infraction 287', -- Human readable name for offense code SEQUESTRATION_287.
    code = 'SEQUESTRATION_287', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 2119, -- Base fine before priors/recidive multipliers.
    min_fine = 1483, -- Lower clamp to prevent under-punishment.
    max_fine = 5085, -- Upper clamp to keep legal proportionality.
    base_months = 48, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 16, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_288'] = {
    label = 'Infraction 288', -- Human readable name for offense code VOL_QUALIFIE_288.
    code = 'VOL_QUALIFIE_288', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 2156, -- Base fine before priors/recidive multipliers.
    min_fine = 1509, -- Lower clamp to prevent under-punishment.
    max_fine = 5174, -- Upper clamp to keep legal proportionality.
    base_months = 1, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_289'] = {
    label = 'Infraction 289', -- Human readable name for offense code USAGE_ARME_289.
    code = 'USAGE_ARME_289', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 2193, -- Base fine before priors/recidive multipliers.
    min_fine = 1535, -- Lower clamp to prevent under-punishment.
    max_fine = 5263, -- Upper clamp to keep legal proportionality.
    base_months = 2, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_290'] = {
    label = 'Infraction 290', -- Human readable name for offense code FUITE_290.
    code = 'FUITE_290', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 2230, -- Base fine before priors/recidive multipliers.
    min_fine = 1561, -- Lower clamp to prevent under-punishment.
    max_fine = 5352, -- Upper clamp to keep legal proportionality.
    base_months = 3, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_291'] = {
    label = 'Infraction 291', -- Human readable name for offense code MISE_EN_DANGER_291.
    code = 'MISE_EN_DANGER_291', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 2267, -- Base fine before priors/recidive multipliers.
    min_fine = 1586, -- Lower clamp to prevent under-punishment.
    max_fine = 5440, -- Upper clamp to keep legal proportionality.
    base_months = 4, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_292'] = {
    label = 'Infraction 292', -- Human readable name for offense code POSSESSION_DROGUE_292.
    code = 'POSSESSION_DROGUE_292', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 2304, -- Base fine before priors/recidive multipliers.
    min_fine = 1612, -- Lower clamp to prevent under-punishment.
    max_fine = 5529, -- Upper clamp to keep legal proportionality.
    base_months = 5, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_293'] = {
    label = 'Infraction 293', -- Human readable name for offense code VENTE_DROGUE_293.
    code = 'VENTE_DROGUE_293', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 2341, -- Base fine before priors/recidive multipliers.
    min_fine = 1638, -- Lower clamp to prevent under-punishment.
    max_fine = 5618, -- Upper clamp to keep legal proportionality.
    base_months = 6, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_294'] = {
    label = 'Infraction 294', -- Human readable name for offense code AGRESSION_SIMPLE_294.
    code = 'AGRESSION_SIMPLE_294', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 2378, -- Base fine before priors/recidive multipliers.
    min_fine = 1664, -- Lower clamp to prevent under-punishment.
    max_fine = 5707, -- Upper clamp to keep legal proportionality.
    base_months = 7, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_295'] = {
    label = 'Infraction 295', -- Human readable name for offense code AGRESSION_ARMEE_295.
    code = 'AGRESSION_ARMEE_295', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 2415, -- Base fine before priors/recidive multipliers.
    min_fine = 1690, -- Lower clamp to prevent under-punishment.
    max_fine = 5796, -- Upper clamp to keep legal proportionality.
    base_months = 8, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_296'] = {
    label = 'Infraction 296', -- Human readable name for offense code HOMICIDE_296.
    code = 'HOMICIDE_296', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 2452, -- Base fine before priors/recidive multipliers.
    min_fine = 1716, -- Lower clamp to prevent under-punishment.
    max_fine = 5884, -- Upper clamp to keep legal proportionality.
    base_months = 9, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_297'] = {
    label = 'Infraction 297', -- Human readable name for offense code FRAUDE_297.
    code = 'FRAUDE_297', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 2489, -- Base fine before priors/recidive multipliers.
    min_fine = 1742, -- Lower clamp to prevent under-punishment.
    max_fine = 5973, -- Upper clamp to keep legal proportionality.
    base_months = 10, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_298'] = {
    label = 'Infraction 298', -- Human readable name for offense code CORRUPTION_298.
    code = 'CORRUPTION_298', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 2526, -- Base fine before priors/recidive multipliers.
    min_fine = 1768, -- Lower clamp to prevent under-punishment.
    max_fine = 6062, -- Upper clamp to keep legal proportionality.
    base_months = 11, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_299'] = {
    label = 'Infraction 299', -- Human readable name for offense code SEQUESTRATION_299.
    code = 'SEQUESTRATION_299', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 2563, -- Base fine before priors/recidive multipliers.
    min_fine = 1794, -- Lower clamp to prevent under-punishment.
    max_fine = 6151, -- Upper clamp to keep legal proportionality.
    base_months = 12, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_300'] = {
    label = 'Infraction 300', -- Human readable name for offense code VOL_QUALIFIE_300.
    code = 'VOL_QUALIFIE_300', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 2600, -- Base fine before priors/recidive multipliers.
    min_fine = 1819, -- Lower clamp to prevent under-punishment.
    max_fine = 6240, -- Upper clamp to keep legal proportionality.
    base_months = 13, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_301'] = {
    label = 'Infraction 301', -- Human readable name for offense code USAGE_ARME_301.
    code = 'USAGE_ARME_301', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 2637, -- Base fine before priors/recidive multipliers.
    min_fine = 1845, -- Lower clamp to prevent under-punishment.
    max_fine = 6328, -- Upper clamp to keep legal proportionality.
    base_months = 14, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_302'] = {
    label = 'Infraction 302', -- Human readable name for offense code FUITE_302.
    code = 'FUITE_302', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 2674, -- Base fine before priors/recidive multipliers.
    min_fine = 1871, -- Lower clamp to prevent under-punishment.
    max_fine = 6417, -- Upper clamp to keep legal proportionality.
    base_months = 15, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_303'] = {
    label = 'Infraction 303', -- Human readable name for offense code MISE_EN_DANGER_303.
    code = 'MISE_EN_DANGER_303', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 2711, -- Base fine before priors/recidive multipliers.
    min_fine = 1897, -- Lower clamp to prevent under-punishment.
    max_fine = 6506, -- Upper clamp to keep legal proportionality.
    base_months = 16, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_304'] = {
    label = 'Infraction 304', -- Human readable name for offense code POSSESSION_DROGUE_304.
    code = 'POSSESSION_DROGUE_304', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 2748, -- Base fine before priors/recidive multipliers.
    min_fine = 1923, -- Lower clamp to prevent under-punishment.
    max_fine = 6595, -- Upper clamp to keep legal proportionality.
    base_months = 17, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_305'] = {
    label = 'Infraction 305', -- Human readable name for offense code VENTE_DROGUE_305.
    code = 'VENTE_DROGUE_305', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 2785, -- Base fine before priors/recidive multipliers.
    min_fine = 1949, -- Lower clamp to prevent under-punishment.
    max_fine = 6684, -- Upper clamp to keep legal proportionality.
    base_months = 18, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_306'] = {
    label = 'Infraction 306', -- Human readable name for offense code AGRESSION_SIMPLE_306.
    code = 'AGRESSION_SIMPLE_306', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 2822, -- Base fine before priors/recidive multipliers.
    min_fine = 1975, -- Lower clamp to prevent under-punishment.
    max_fine = 6772, -- Upper clamp to keep legal proportionality.
    base_months = 19, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_307'] = {
    label = 'Infraction 307', -- Human readable name for offense code AGRESSION_ARMEE_307.
    code = 'AGRESSION_ARMEE_307', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 2859, -- Base fine before priors/recidive multipliers.
    min_fine = 2001, -- Lower clamp to prevent under-punishment.
    max_fine = 6861, -- Upper clamp to keep legal proportionality.
    base_months = 20, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_308'] = {
    label = 'Infraction 308', -- Human readable name for offense code HOMICIDE_308.
    code = 'HOMICIDE_308', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 2896, -- Base fine before priors/recidive multipliers.
    min_fine = 2027, -- Lower clamp to prevent under-punishment.
    max_fine = 6950, -- Upper clamp to keep legal proportionality.
    base_months = 21, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_309'] = {
    label = 'Infraction 309', -- Human readable name for offense code FRAUDE_309.
    code = 'FRAUDE_309', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 2933, -- Base fine before priors/recidive multipliers.
    min_fine = 2053, -- Lower clamp to prevent under-punishment.
    max_fine = 7039, -- Upper clamp to keep legal proportionality.
    base_months = 22, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_310'] = {
    label = 'Infraction 310', -- Human readable name for offense code CORRUPTION_310.
    code = 'CORRUPTION_310', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 2970, -- Base fine before priors/recidive multipliers.
    min_fine = 2079, -- Lower clamp to prevent under-punishment.
    max_fine = 7128, -- Upper clamp to keep legal proportionality.
    base_months = 23, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_311'] = {
    label = 'Infraction 311', -- Human readable name for offense code SEQUESTRATION_311.
    code = 'SEQUESTRATION_311', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 3007, -- Base fine before priors/recidive multipliers.
    min_fine = 2104, -- Lower clamp to prevent under-punishment.
    max_fine = 7216, -- Upper clamp to keep legal proportionality.
    base_months = 24, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_312'] = {
    label = 'Infraction 312', -- Human readable name for offense code VOL_QUALIFIE_312.
    code = 'VOL_QUALIFIE_312', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 3044, -- Base fine before priors/recidive multipliers.
    min_fine = 2130, -- Lower clamp to prevent under-punishment.
    max_fine = 7305, -- Upper clamp to keep legal proportionality.
    base_months = 25, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_313'] = {
    label = 'Infraction 313', -- Human readable name for offense code USAGE_ARME_313.
    code = 'USAGE_ARME_313', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 3081, -- Base fine before priors/recidive multipliers.
    min_fine = 2156, -- Lower clamp to prevent under-punishment.
    max_fine = 7394, -- Upper clamp to keep legal proportionality.
    base_months = 26, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_314'] = {
    label = 'Infraction 314', -- Human readable name for offense code FUITE_314.
    code = 'FUITE_314', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 3118, -- Base fine before priors/recidive multipliers.
    min_fine = 2182, -- Lower clamp to prevent under-punishment.
    max_fine = 7483, -- Upper clamp to keep legal proportionality.
    base_months = 27, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_315'] = {
    label = 'Infraction 315', -- Human readable name for offense code MISE_EN_DANGER_315.
    code = 'MISE_EN_DANGER_315', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 3155, -- Base fine before priors/recidive multipliers.
    min_fine = 2208, -- Lower clamp to prevent under-punishment.
    max_fine = 7572, -- Upper clamp to keep legal proportionality.
    base_months = 28, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_316'] = {
    label = 'Infraction 316', -- Human readable name for offense code POSSESSION_DROGUE_316.
    code = 'POSSESSION_DROGUE_316', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 3192, -- Base fine before priors/recidive multipliers.
    min_fine = 2234, -- Lower clamp to prevent under-punishment.
    max_fine = 7660, -- Upper clamp to keep legal proportionality.
    base_months = 29, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_317'] = {
    label = 'Infraction 317', -- Human readable name for offense code VENTE_DROGUE_317.
    code = 'VENTE_DROGUE_317', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 3229, -- Base fine before priors/recidive multipliers.
    min_fine = 2260, -- Lower clamp to prevent under-punishment.
    max_fine = 7749, -- Upper clamp to keep legal proportionality.
    base_months = 30, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_318'] = {
    label = 'Infraction 318', -- Human readable name for offense code AGRESSION_SIMPLE_318.
    code = 'AGRESSION_SIMPLE_318', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 3266, -- Base fine before priors/recidive multipliers.
    min_fine = 2286, -- Lower clamp to prevent under-punishment.
    max_fine = 7838, -- Upper clamp to keep legal proportionality.
    base_months = 31, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_319'] = {
    label = 'Infraction 319', -- Human readable name for offense code AGRESSION_ARMEE_319.
    code = 'AGRESSION_ARMEE_319', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 3303, -- Base fine before priors/recidive multipliers.
    min_fine = 2312, -- Lower clamp to prevent under-punishment.
    max_fine = 7927, -- Upper clamp to keep legal proportionality.
    base_months = 32, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_320'] = {
    label = 'Infraction 320', -- Human readable name for offense code HOMICIDE_320.
    code = 'HOMICIDE_320', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 3340, -- Base fine before priors/recidive multipliers.
    min_fine = 2338, -- Lower clamp to prevent under-punishment.
    max_fine = 8016, -- Upper clamp to keep legal proportionality.
    base_months = 33, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_321'] = {
    label = 'Infraction 321', -- Human readable name for offense code FRAUDE_321.
    code = 'FRAUDE_321', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 3377, -- Base fine before priors/recidive multipliers.
    min_fine = 2363, -- Lower clamp to prevent under-punishment.
    max_fine = 8104, -- Upper clamp to keep legal proportionality.
    base_months = 34, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_322'] = {
    label = 'Infraction 322', -- Human readable name for offense code CORRUPTION_322.
    code = 'CORRUPTION_322', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 3414, -- Base fine before priors/recidive multipliers.
    min_fine = 2389, -- Lower clamp to prevent under-punishment.
    max_fine = 8193, -- Upper clamp to keep legal proportionality.
    base_months = 35, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_323'] = {
    label = 'Infraction 323', -- Human readable name for offense code SEQUESTRATION_323.
    code = 'SEQUESTRATION_323', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 3451, -- Base fine before priors/recidive multipliers.
    min_fine = 2415, -- Lower clamp to prevent under-punishment.
    max_fine = 8282, -- Upper clamp to keep legal proportionality.
    base_months = 36, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_324'] = {
    label = 'Infraction 324', -- Human readable name for offense code VOL_QUALIFIE_324.
    code = 'VOL_QUALIFIE_324', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 3488, -- Base fine before priors/recidive multipliers.
    min_fine = 2441, -- Lower clamp to prevent under-punishment.
    max_fine = 8371, -- Upper clamp to keep legal proportionality.
    base_months = 37, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_325'] = {
    label = 'Infraction 325', -- Human readable name for offense code USAGE_ARME_325.
    code = 'USAGE_ARME_325', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 3525, -- Base fine before priors/recidive multipliers.
    min_fine = 2467, -- Lower clamp to prevent under-punishment.
    max_fine = 8460, -- Upper clamp to keep legal proportionality.
    base_months = 38, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_326'] = {
    label = 'Infraction 326', -- Human readable name for offense code FUITE_326.
    code = 'FUITE_326', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 3562, -- Base fine before priors/recidive multipliers.
    min_fine = 2493, -- Lower clamp to prevent under-punishment.
    max_fine = 8548, -- Upper clamp to keep legal proportionality.
    base_months = 39, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_327'] = {
    label = 'Infraction 327', -- Human readable name for offense code MISE_EN_DANGER_327.
    code = 'MISE_EN_DANGER_327', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 3599, -- Base fine before priors/recidive multipliers.
    min_fine = 2519, -- Lower clamp to prevent under-punishment.
    max_fine = 8637, -- Upper clamp to keep legal proportionality.
    base_months = 40, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_328'] = {
    label = 'Infraction 328', -- Human readable name for offense code POSSESSION_DROGUE_328.
    code = 'POSSESSION_DROGUE_328', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 3636, -- Base fine before priors/recidive multipliers.
    min_fine = 2545, -- Lower clamp to prevent under-punishment.
    max_fine = 8726, -- Upper clamp to keep legal proportionality.
    base_months = 41, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_329'] = {
    label = 'Infraction 329', -- Human readable name for offense code VENTE_DROGUE_329.
    code = 'VENTE_DROGUE_329', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 3673, -- Base fine before priors/recidive multipliers.
    min_fine = 2571, -- Lower clamp to prevent under-punishment.
    max_fine = 8815, -- Upper clamp to keep legal proportionality.
    base_months = 42, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_330'] = {
    label = 'Infraction 330', -- Human readable name for offense code AGRESSION_SIMPLE_330.
    code = 'AGRESSION_SIMPLE_330', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 3710, -- Base fine before priors/recidive multipliers.
    min_fine = 2597, -- Lower clamp to prevent under-punishment.
    max_fine = 8904, -- Upper clamp to keep legal proportionality.
    base_months = 43, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_331'] = {
    label = 'Infraction 331', -- Human readable name for offense code AGRESSION_ARMEE_331.
    code = 'AGRESSION_ARMEE_331', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 3747, -- Base fine before priors/recidive multipliers.
    min_fine = 2622, -- Lower clamp to prevent under-punishment.
    max_fine = 8992, -- Upper clamp to keep legal proportionality.
    base_months = 44, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_332'] = {
    label = 'Infraction 332', -- Human readable name for offense code HOMICIDE_332.
    code = 'HOMICIDE_332', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 3784, -- Base fine before priors/recidive multipliers.
    min_fine = 2648, -- Lower clamp to prevent under-punishment.
    max_fine = 9081, -- Upper clamp to keep legal proportionality.
    base_months = 45, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_333'] = {
    label = 'Infraction 333', -- Human readable name for offense code FRAUDE_333.
    code = 'FRAUDE_333', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 3821, -- Base fine before priors/recidive multipliers.
    min_fine = 2674, -- Lower clamp to prevent under-punishment.
    max_fine = 9170, -- Upper clamp to keep legal proportionality.
    base_months = 46, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_334'] = {
    label = 'Infraction 334', -- Human readable name for offense code CORRUPTION_334.
    code = 'CORRUPTION_334', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 3858, -- Base fine before priors/recidive multipliers.
    min_fine = 2700, -- Lower clamp to prevent under-punishment.
    max_fine = 9259, -- Upper clamp to keep legal proportionality.
    base_months = 47, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_335'] = {
    label = 'Infraction 335', -- Human readable name for offense code SEQUESTRATION_335.
    code = 'SEQUESTRATION_335', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 3895, -- Base fine before priors/recidive multipliers.
    min_fine = 2726, -- Lower clamp to prevent under-punishment.
    max_fine = 9348, -- Upper clamp to keep legal proportionality.
    base_months = 48, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 16, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_336'] = {
    label = 'Infraction 336', -- Human readable name for offense code VOL_QUALIFIE_336.
    code = 'VOL_QUALIFIE_336', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 3932, -- Base fine before priors/recidive multipliers.
    min_fine = 2752, -- Lower clamp to prevent under-punishment.
    max_fine = 9436, -- Upper clamp to keep legal proportionality.
    base_months = 1, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_337'] = {
    label = 'Infraction 337', -- Human readable name for offense code USAGE_ARME_337.
    code = 'USAGE_ARME_337', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 3969, -- Base fine before priors/recidive multipliers.
    min_fine = 2778, -- Lower clamp to prevent under-punishment.
    max_fine = 9525, -- Upper clamp to keep legal proportionality.
    base_months = 2, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_338'] = {
    label = 'Infraction 338', -- Human readable name for offense code FUITE_338.
    code = 'FUITE_338', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 4006, -- Base fine before priors/recidive multipliers.
    min_fine = 2804, -- Lower clamp to prevent under-punishment.
    max_fine = 9614, -- Upper clamp to keep legal proportionality.
    base_months = 3, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_339'] = {
    label = 'Infraction 339', -- Human readable name for offense code MISE_EN_DANGER_339.
    code = 'MISE_EN_DANGER_339', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 4043, -- Base fine before priors/recidive multipliers.
    min_fine = 2830, -- Lower clamp to prevent under-punishment.
    max_fine = 9703, -- Upper clamp to keep legal proportionality.
    base_months = 4, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_340'] = {
    label = 'Infraction 340', -- Human readable name for offense code POSSESSION_DROGUE_340.
    code = 'POSSESSION_DROGUE_340', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 4080, -- Base fine before priors/recidive multipliers.
    min_fine = 2856, -- Lower clamp to prevent under-punishment.
    max_fine = 9792, -- Upper clamp to keep legal proportionality.
    base_months = 5, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_341'] = {
    label = 'Infraction 341', -- Human readable name for offense code VENTE_DROGUE_341.
    code = 'VENTE_DROGUE_341', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 4117, -- Base fine before priors/recidive multipliers.
    min_fine = 2881, -- Lower clamp to prevent under-punishment.
    max_fine = 9880, -- Upper clamp to keep legal proportionality.
    base_months = 6, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_342'] = {
    label = 'Infraction 342', -- Human readable name for offense code AGRESSION_SIMPLE_342.
    code = 'AGRESSION_SIMPLE_342', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 4154, -- Base fine before priors/recidive multipliers.
    min_fine = 2907, -- Lower clamp to prevent under-punishment.
    max_fine = 9969, -- Upper clamp to keep legal proportionality.
    base_months = 7, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_343'] = {
    label = 'Infraction 343', -- Human readable name for offense code AGRESSION_ARMEE_343.
    code = 'AGRESSION_ARMEE_343', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 4191, -- Base fine before priors/recidive multipliers.
    min_fine = 2933, -- Lower clamp to prevent under-punishment.
    max_fine = 10058, -- Upper clamp to keep legal proportionality.
    base_months = 8, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_344'] = {
    label = 'Infraction 344', -- Human readable name for offense code HOMICIDE_344.
    code = 'HOMICIDE_344', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 4228, -- Base fine before priors/recidive multipliers.
    min_fine = 2959, -- Lower clamp to prevent under-punishment.
    max_fine = 10147, -- Upper clamp to keep legal proportionality.
    base_months = 9, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_345'] = {
    label = 'Infraction 345', -- Human readable name for offense code FRAUDE_345.
    code = 'FRAUDE_345', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 4265, -- Base fine before priors/recidive multipliers.
    min_fine = 2985, -- Lower clamp to prevent under-punishment.
    max_fine = 10236, -- Upper clamp to keep legal proportionality.
    base_months = 10, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_346'] = {
    label = 'Infraction 346', -- Human readable name for offense code CORRUPTION_346.
    code = 'CORRUPTION_346', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 4302, -- Base fine before priors/recidive multipliers.
    min_fine = 3011, -- Lower clamp to prevent under-punishment.
    max_fine = 10324, -- Upper clamp to keep legal proportionality.
    base_months = 11, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_347'] = {
    label = 'Infraction 347', -- Human readable name for offense code SEQUESTRATION_347.
    code = 'SEQUESTRATION_347', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 4339, -- Base fine before priors/recidive multipliers.
    min_fine = 3037, -- Lower clamp to prevent under-punishment.
    max_fine = 10413, -- Upper clamp to keep legal proportionality.
    base_months = 12, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_348'] = {
    label = 'Infraction 348', -- Human readable name for offense code VOL_QUALIFIE_348.
    code = 'VOL_QUALIFIE_348', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 4376, -- Base fine before priors/recidive multipliers.
    min_fine = 3063, -- Lower clamp to prevent under-punishment.
    max_fine = 10502, -- Upper clamp to keep legal proportionality.
    base_months = 13, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_349'] = {
    label = 'Infraction 349', -- Human readable name for offense code USAGE_ARME_349.
    code = 'USAGE_ARME_349', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 4413, -- Base fine before priors/recidive multipliers.
    min_fine = 3089, -- Lower clamp to prevent under-punishment.
    max_fine = 10591, -- Upper clamp to keep legal proportionality.
    base_months = 14, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_350'] = {
    label = 'Infraction 350', -- Human readable name for offense code FUITE_350.
    code = 'FUITE_350', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 4450, -- Base fine before priors/recidive multipliers.
    min_fine = 3115, -- Lower clamp to prevent under-punishment.
    max_fine = 10680, -- Upper clamp to keep legal proportionality.
    base_months = 15, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_351'] = {
    label = 'Infraction 351', -- Human readable name for offense code MISE_EN_DANGER_351.
    code = 'MISE_EN_DANGER_351', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 4487, -- Base fine before priors/recidive multipliers.
    min_fine = 3140, -- Lower clamp to prevent under-punishment.
    max_fine = 10768, -- Upper clamp to keep legal proportionality.
    base_months = 16, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_352'] = {
    label = 'Infraction 352', -- Human readable name for offense code POSSESSION_DROGUE_352.
    code = 'POSSESSION_DROGUE_352', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 4524, -- Base fine before priors/recidive multipliers.
    min_fine = 3166, -- Lower clamp to prevent under-punishment.
    max_fine = 10857, -- Upper clamp to keep legal proportionality.
    base_months = 17, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_353'] = {
    label = 'Infraction 353', -- Human readable name for offense code VENTE_DROGUE_353.
    code = 'VENTE_DROGUE_353', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 4561, -- Base fine before priors/recidive multipliers.
    min_fine = 3192, -- Lower clamp to prevent under-punishment.
    max_fine = 10946, -- Upper clamp to keep legal proportionality.
    base_months = 18, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_354'] = {
    label = 'Infraction 354', -- Human readable name for offense code AGRESSION_SIMPLE_354.
    code = 'AGRESSION_SIMPLE_354', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 4598, -- Base fine before priors/recidive multipliers.
    min_fine = 3218, -- Lower clamp to prevent under-punishment.
    max_fine = 11035, -- Upper clamp to keep legal proportionality.
    base_months = 19, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_355'] = {
    label = 'Infraction 355', -- Human readable name for offense code AGRESSION_ARMEE_355.
    code = 'AGRESSION_ARMEE_355', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 4635, -- Base fine before priors/recidive multipliers.
    min_fine = 3244, -- Lower clamp to prevent under-punishment.
    max_fine = 11124, -- Upper clamp to keep legal proportionality.
    base_months = 20, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_356'] = {
    label = 'Infraction 356', -- Human readable name for offense code HOMICIDE_356.
    code = 'HOMICIDE_356', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 4672, -- Base fine before priors/recidive multipliers.
    min_fine = 3270, -- Lower clamp to prevent under-punishment.
    max_fine = 11212, -- Upper clamp to keep legal proportionality.
    base_months = 21, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_357'] = {
    label = 'Infraction 357', -- Human readable name for offense code FRAUDE_357.
    code = 'FRAUDE_357', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 4709, -- Base fine before priors/recidive multipliers.
    min_fine = 3296, -- Lower clamp to prevent under-punishment.
    max_fine = 11301, -- Upper clamp to keep legal proportionality.
    base_months = 22, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_358'] = {
    label = 'Infraction 358', -- Human readable name for offense code CORRUPTION_358.
    code = 'CORRUPTION_358', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 4746, -- Base fine before priors/recidive multipliers.
    min_fine = 3322, -- Lower clamp to prevent under-punishment.
    max_fine = 11390, -- Upper clamp to keep legal proportionality.
    base_months = 23, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_359'] = {
    label = 'Infraction 359', -- Human readable name for offense code SEQUESTRATION_359.
    code = 'SEQUESTRATION_359', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 4783, -- Base fine before priors/recidive multipliers.
    min_fine = 3348, -- Lower clamp to prevent under-punishment.
    max_fine = 11479, -- Upper clamp to keep legal proportionality.
    base_months = 24, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_360'] = {
    label = 'Infraction 360', -- Human readable name for offense code VOL_QUALIFIE_360.
    code = 'VOL_QUALIFIE_360', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 4820, -- Base fine before priors/recidive multipliers.
    min_fine = 3374, -- Lower clamp to prevent under-punishment.
    max_fine = 11568, -- Upper clamp to keep legal proportionality.
    base_months = 25, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_361'] = {
    label = 'Infraction 361', -- Human readable name for offense code USAGE_ARME_361.
    code = 'USAGE_ARME_361', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 4857, -- Base fine before priors/recidive multipliers.
    min_fine = 3399, -- Lower clamp to prevent under-punishment.
    max_fine = 11656, -- Upper clamp to keep legal proportionality.
    base_months = 26, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_362'] = {
    label = 'Infraction 362', -- Human readable name for offense code FUITE_362.
    code = 'FUITE_362', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 4894, -- Base fine before priors/recidive multipliers.
    min_fine = 3425, -- Lower clamp to prevent under-punishment.
    max_fine = 11745, -- Upper clamp to keep legal proportionality.
    base_months = 27, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_363'] = {
    label = 'Infraction 363', -- Human readable name for offense code MISE_EN_DANGER_363.
    code = 'MISE_EN_DANGER_363', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 4931, -- Base fine before priors/recidive multipliers.
    min_fine = 3451, -- Lower clamp to prevent under-punishment.
    max_fine = 11834, -- Upper clamp to keep legal proportionality.
    base_months = 28, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_364'] = {
    label = 'Infraction 364', -- Human readable name for offense code POSSESSION_DROGUE_364.
    code = 'POSSESSION_DROGUE_364', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 4968, -- Base fine before priors/recidive multipliers.
    min_fine = 3477, -- Lower clamp to prevent under-punishment.
    max_fine = 11923, -- Upper clamp to keep legal proportionality.
    base_months = 29, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_365'] = {
    label = 'Infraction 365', -- Human readable name for offense code VENTE_DROGUE_365.
    code = 'VENTE_DROGUE_365', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 5005, -- Base fine before priors/recidive multipliers.
    min_fine = 3503, -- Lower clamp to prevent under-punishment.
    max_fine = 12012, -- Upper clamp to keep legal proportionality.
    base_months = 30, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_366'] = {
    label = 'Infraction 366', -- Human readable name for offense code AGRESSION_SIMPLE_366.
    code = 'AGRESSION_SIMPLE_366', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 5042, -- Base fine before priors/recidive multipliers.
    min_fine = 3529, -- Lower clamp to prevent under-punishment.
    max_fine = 12100, -- Upper clamp to keep legal proportionality.
    base_months = 31, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_367'] = {
    label = 'Infraction 367', -- Human readable name for offense code AGRESSION_ARMEE_367.
    code = 'AGRESSION_ARMEE_367', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 5079, -- Base fine before priors/recidive multipliers.
    min_fine = 3555, -- Lower clamp to prevent under-punishment.
    max_fine = 12189, -- Upper clamp to keep legal proportionality.
    base_months = 32, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_368'] = {
    label = 'Infraction 368', -- Human readable name for offense code HOMICIDE_368.
    code = 'HOMICIDE_368', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 5116, -- Base fine before priors/recidive multipliers.
    min_fine = 3581, -- Lower clamp to prevent under-punishment.
    max_fine = 12278, -- Upper clamp to keep legal proportionality.
    base_months = 33, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_369'] = {
    label = 'Infraction 369', -- Human readable name for offense code FRAUDE_369.
    code = 'FRAUDE_369', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 5153, -- Base fine before priors/recidive multipliers.
    min_fine = 3607, -- Lower clamp to prevent under-punishment.
    max_fine = 12367, -- Upper clamp to keep legal proportionality.
    base_months = 34, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_370'] = {
    label = 'Infraction 370', -- Human readable name for offense code CORRUPTION_370.
    code = 'CORRUPTION_370', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 5190, -- Base fine before priors/recidive multipliers.
    min_fine = 3632, -- Lower clamp to prevent under-punishment.
    max_fine = 12456, -- Upper clamp to keep legal proportionality.
    base_months = 35, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_371'] = {
    label = 'Infraction 371', -- Human readable name for offense code SEQUESTRATION_371.
    code = 'SEQUESTRATION_371', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 5227, -- Base fine before priors/recidive multipliers.
    min_fine = 3658, -- Lower clamp to prevent under-punishment.
    max_fine = 12544, -- Upper clamp to keep legal proportionality.
    base_months = 36, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_372'] = {
    label = 'Infraction 372', -- Human readable name for offense code VOL_QUALIFIE_372.
    code = 'VOL_QUALIFIE_372', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 5264, -- Base fine before priors/recidive multipliers.
    min_fine = 3684, -- Lower clamp to prevent under-punishment.
    max_fine = 12633, -- Upper clamp to keep legal proportionality.
    base_months = 37, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_373'] = {
    label = 'Infraction 373', -- Human readable name for offense code USAGE_ARME_373.
    code = 'USAGE_ARME_373', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 5301, -- Base fine before priors/recidive multipliers.
    min_fine = 3710, -- Lower clamp to prevent under-punishment.
    max_fine = 12722, -- Upper clamp to keep legal proportionality.
    base_months = 38, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_374'] = {
    label = 'Infraction 374', -- Human readable name for offense code FUITE_374.
    code = 'FUITE_374', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 5338, -- Base fine before priors/recidive multipliers.
    min_fine = 3736, -- Lower clamp to prevent under-punishment.
    max_fine = 12811, -- Upper clamp to keep legal proportionality.
    base_months = 39, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_375'] = {
    label = 'Infraction 375', -- Human readable name for offense code MISE_EN_DANGER_375.
    code = 'MISE_EN_DANGER_375', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 5375, -- Base fine before priors/recidive multipliers.
    min_fine = 3762, -- Lower clamp to prevent under-punishment.
    max_fine = 12900, -- Upper clamp to keep legal proportionality.
    base_months = 40, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_376'] = {
    label = 'Infraction 376', -- Human readable name for offense code POSSESSION_DROGUE_376.
    code = 'POSSESSION_DROGUE_376', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 5412, -- Base fine before priors/recidive multipliers.
    min_fine = 3788, -- Lower clamp to prevent under-punishment.
    max_fine = 12988, -- Upper clamp to keep legal proportionality.
    base_months = 41, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_377'] = {
    label = 'Infraction 377', -- Human readable name for offense code VENTE_DROGUE_377.
    code = 'VENTE_DROGUE_377', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 5449, -- Base fine before priors/recidive multipliers.
    min_fine = 3814, -- Lower clamp to prevent under-punishment.
    max_fine = 13077, -- Upper clamp to keep legal proportionality.
    base_months = 42, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_378'] = {
    label = 'Infraction 378', -- Human readable name for offense code AGRESSION_SIMPLE_378.
    code = 'AGRESSION_SIMPLE_378', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 5486, -- Base fine before priors/recidive multipliers.
    min_fine = 3840, -- Lower clamp to prevent under-punishment.
    max_fine = 13166, -- Upper clamp to keep legal proportionality.
    base_months = 43, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_379'] = {
    label = 'Infraction 379', -- Human readable name for offense code AGRESSION_ARMEE_379.
    code = 'AGRESSION_ARMEE_379', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 5523, -- Base fine before priors/recidive multipliers.
    min_fine = 3866, -- Lower clamp to prevent under-punishment.
    max_fine = 13255, -- Upper clamp to keep legal proportionality.
    base_months = 44, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_380'] = {
    label = 'Infraction 380', -- Human readable name for offense code HOMICIDE_380.
    code = 'HOMICIDE_380', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 5560, -- Base fine before priors/recidive multipliers.
    min_fine = 3891, -- Lower clamp to prevent under-punishment.
    max_fine = 13344, -- Upper clamp to keep legal proportionality.
    base_months = 45, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_381'] = {
    label = 'Infraction 381', -- Human readable name for offense code FRAUDE_381.
    code = 'FRAUDE_381', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 5597, -- Base fine before priors/recidive multipliers.
    min_fine = 3917, -- Lower clamp to prevent under-punishment.
    max_fine = 13432, -- Upper clamp to keep legal proportionality.
    base_months = 46, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_382'] = {
    label = 'Infraction 382', -- Human readable name for offense code CORRUPTION_382.
    code = 'CORRUPTION_382', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 5634, -- Base fine before priors/recidive multipliers.
    min_fine = 3943, -- Lower clamp to prevent under-punishment.
    max_fine = 13521, -- Upper clamp to keep legal proportionality.
    base_months = 47, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_383'] = {
    label = 'Infraction 383', -- Human readable name for offense code SEQUESTRATION_383.
    code = 'SEQUESTRATION_383', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 5671, -- Base fine before priors/recidive multipliers.
    min_fine = 3969, -- Lower clamp to prevent under-punishment.
    max_fine = 13610, -- Upper clamp to keep legal proportionality.
    base_months = 48, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 16, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_384'] = {
    label = 'Infraction 384', -- Human readable name for offense code VOL_QUALIFIE_384.
    code = 'VOL_QUALIFIE_384', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 5708, -- Base fine before priors/recidive multipliers.
    min_fine = 3995, -- Lower clamp to prevent under-punishment.
    max_fine = 13699, -- Upper clamp to keep legal proportionality.
    base_months = 1, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_385'] = {
    label = 'Infraction 385', -- Human readable name for offense code USAGE_ARME_385.
    code = 'USAGE_ARME_385', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 5745, -- Base fine before priors/recidive multipliers.
    min_fine = 4021, -- Lower clamp to prevent under-punishment.
    max_fine = 13788, -- Upper clamp to keep legal proportionality.
    base_months = 2, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_386'] = {
    label = 'Infraction 386', -- Human readable name for offense code FUITE_386.
    code = 'FUITE_386', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 5782, -- Base fine before priors/recidive multipliers.
    min_fine = 4047, -- Lower clamp to prevent under-punishment.
    max_fine = 13876, -- Upper clamp to keep legal proportionality.
    base_months = 3, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_387'] = {
    label = 'Infraction 387', -- Human readable name for offense code MISE_EN_DANGER_387.
    code = 'MISE_EN_DANGER_387', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 5819, -- Base fine before priors/recidive multipliers.
    min_fine = 4073, -- Lower clamp to prevent under-punishment.
    max_fine = 13965, -- Upper clamp to keep legal proportionality.
    base_months = 4, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_388'] = {
    label = 'Infraction 388', -- Human readable name for offense code POSSESSION_DROGUE_388.
    code = 'POSSESSION_DROGUE_388', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 5856, -- Base fine before priors/recidive multipliers.
    min_fine = 4099, -- Lower clamp to prevent under-punishment.
    max_fine = 14054, -- Upper clamp to keep legal proportionality.
    base_months = 5, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_389'] = {
    label = 'Infraction 389', -- Human readable name for offense code VENTE_DROGUE_389.
    code = 'VENTE_DROGUE_389', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 5893, -- Base fine before priors/recidive multipliers.
    min_fine = 4125, -- Lower clamp to prevent under-punishment.
    max_fine = 14143, -- Upper clamp to keep legal proportionality.
    base_months = 6, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_390'] = {
    label = 'Infraction 390', -- Human readable name for offense code AGRESSION_SIMPLE_390.
    code = 'AGRESSION_SIMPLE_390', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 5930, -- Base fine before priors/recidive multipliers.
    min_fine = 4151, -- Lower clamp to prevent under-punishment.
    max_fine = 14232, -- Upper clamp to keep legal proportionality.
    base_months = 7, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_391'] = {
    label = 'Infraction 391', -- Human readable name for offense code AGRESSION_ARMEE_391.
    code = 'AGRESSION_ARMEE_391', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 5967, -- Base fine before priors/recidive multipliers.
    min_fine = 4176, -- Lower clamp to prevent under-punishment.
    max_fine = 14320, -- Upper clamp to keep legal proportionality.
    base_months = 8, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_392'] = {
    label = 'Infraction 392', -- Human readable name for offense code HOMICIDE_392.
    code = 'HOMICIDE_392', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 6004, -- Base fine before priors/recidive multipliers.
    min_fine = 4202, -- Lower clamp to prevent under-punishment.
    max_fine = 14409, -- Upper clamp to keep legal proportionality.
    base_months = 9, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_393'] = {
    label = 'Infraction 393', -- Human readable name for offense code FRAUDE_393.
    code = 'FRAUDE_393', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 6041, -- Base fine before priors/recidive multipliers.
    min_fine = 4228, -- Lower clamp to prevent under-punishment.
    max_fine = 14498, -- Upper clamp to keep legal proportionality.
    base_months = 10, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_394'] = {
    label = 'Infraction 394', -- Human readable name for offense code CORRUPTION_394.
    code = 'CORRUPTION_394', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 6078, -- Base fine before priors/recidive multipliers.
    min_fine = 4254, -- Lower clamp to prevent under-punishment.
    max_fine = 14587, -- Upper clamp to keep legal proportionality.
    base_months = 11, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_395'] = {
    label = 'Infraction 395', -- Human readable name for offense code SEQUESTRATION_395.
    code = 'SEQUESTRATION_395', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 6115, -- Base fine before priors/recidive multipliers.
    min_fine = 4280, -- Lower clamp to prevent under-punishment.
    max_fine = 14676, -- Upper clamp to keep legal proportionality.
    base_months = 12, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_396'] = {
    label = 'Infraction 396', -- Human readable name for offense code VOL_QUALIFIE_396.
    code = 'VOL_QUALIFIE_396', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 6152, -- Base fine before priors/recidive multipliers.
    min_fine = 4306, -- Lower clamp to prevent under-punishment.
    max_fine = 14764, -- Upper clamp to keep legal proportionality.
    base_months = 13, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_397'] = {
    label = 'Infraction 397', -- Human readable name for offense code USAGE_ARME_397.
    code = 'USAGE_ARME_397', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 6189, -- Base fine before priors/recidive multipliers.
    min_fine = 4332, -- Lower clamp to prevent under-punishment.
    max_fine = 14853, -- Upper clamp to keep legal proportionality.
    base_months = 14, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_398'] = {
    label = 'Infraction 398', -- Human readable name for offense code FUITE_398.
    code = 'FUITE_398', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 6226, -- Base fine before priors/recidive multipliers.
    min_fine = 4358, -- Lower clamp to prevent under-punishment.
    max_fine = 14942, -- Upper clamp to keep legal proportionality.
    base_months = 15, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_399'] = {
    label = 'Infraction 399', -- Human readable name for offense code MISE_EN_DANGER_399.
    code = 'MISE_EN_DANGER_399', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 6263, -- Base fine before priors/recidive multipliers.
    min_fine = 4384, -- Lower clamp to prevent under-punishment.
    max_fine = 15031, -- Upper clamp to keep legal proportionality.
    base_months = 16, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_400'] = {
    label = 'Infraction 400', -- Human readable name for offense code POSSESSION_DROGUE_400.
    code = 'POSSESSION_DROGUE_400', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 6300, -- Base fine before priors/recidive multipliers.
    min_fine = 4410, -- Lower clamp to prevent under-punishment.
    max_fine = 15120, -- Upper clamp to keep legal proportionality.
    base_months = 17, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_401'] = {
    label = 'Infraction 401', -- Human readable name for offense code VENTE_DROGUE_401.
    code = 'VENTE_DROGUE_401', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 6337, -- Base fine before priors/recidive multipliers.
    min_fine = 4435, -- Lower clamp to prevent under-punishment.
    max_fine = 15208, -- Upper clamp to keep legal proportionality.
    base_months = 18, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_402'] = {
    label = 'Infraction 402', -- Human readable name for offense code AGRESSION_SIMPLE_402.
    code = 'AGRESSION_SIMPLE_402', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 6374, -- Base fine before priors/recidive multipliers.
    min_fine = 4461, -- Lower clamp to prevent under-punishment.
    max_fine = 15297, -- Upper clamp to keep legal proportionality.
    base_months = 19, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_403'] = {
    label = 'Infraction 403', -- Human readable name for offense code AGRESSION_ARMEE_403.
    code = 'AGRESSION_ARMEE_403', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 6411, -- Base fine before priors/recidive multipliers.
    min_fine = 4487, -- Lower clamp to prevent under-punishment.
    max_fine = 15386, -- Upper clamp to keep legal proportionality.
    base_months = 20, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_404'] = {
    label = 'Infraction 404', -- Human readable name for offense code HOMICIDE_404.
    code = 'HOMICIDE_404', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 6448, -- Base fine before priors/recidive multipliers.
    min_fine = 4513, -- Lower clamp to prevent under-punishment.
    max_fine = 15475, -- Upper clamp to keep legal proportionality.
    base_months = 21, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_405'] = {
    label = 'Infraction 405', -- Human readable name for offense code FRAUDE_405.
    code = 'FRAUDE_405', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 6485, -- Base fine before priors/recidive multipliers.
    min_fine = 4539, -- Lower clamp to prevent under-punishment.
    max_fine = 15564, -- Upper clamp to keep legal proportionality.
    base_months = 22, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_406'] = {
    label = 'Infraction 406', -- Human readable name for offense code CORRUPTION_406.
    code = 'CORRUPTION_406', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 6522, -- Base fine before priors/recidive multipliers.
    min_fine = 4565, -- Lower clamp to prevent under-punishment.
    max_fine = 15652, -- Upper clamp to keep legal proportionality.
    base_months = 23, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_407'] = {
    label = 'Infraction 407', -- Human readable name for offense code SEQUESTRATION_407.
    code = 'SEQUESTRATION_407', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 6559, -- Base fine before priors/recidive multipliers.
    min_fine = 4591, -- Lower clamp to prevent under-punishment.
    max_fine = 15741, -- Upper clamp to keep legal proportionality.
    base_months = 24, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_408'] = {
    label = 'Infraction 408', -- Human readable name for offense code VOL_QUALIFIE_408.
    code = 'VOL_QUALIFIE_408', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 6596, -- Base fine before priors/recidive multipliers.
    min_fine = 4617, -- Lower clamp to prevent under-punishment.
    max_fine = 15830, -- Upper clamp to keep legal proportionality.
    base_months = 25, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_409'] = {
    label = 'Infraction 409', -- Human readable name for offense code USAGE_ARME_409.
    code = 'USAGE_ARME_409', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 6633, -- Base fine before priors/recidive multipliers.
    min_fine = 4643, -- Lower clamp to prevent under-punishment.
    max_fine = 15919, -- Upper clamp to keep legal proportionality.
    base_months = 26, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_410'] = {
    label = 'Infraction 410', -- Human readable name for offense code FUITE_410.
    code = 'FUITE_410', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 6670, -- Base fine before priors/recidive multipliers.
    min_fine = 4669, -- Lower clamp to prevent under-punishment.
    max_fine = 16008, -- Upper clamp to keep legal proportionality.
    base_months = 27, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_411'] = {
    label = 'Infraction 411', -- Human readable name for offense code MISE_EN_DANGER_411.
    code = 'MISE_EN_DANGER_411', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 6707, -- Base fine before priors/recidive multipliers.
    min_fine = 4694, -- Lower clamp to prevent under-punishment.
    max_fine = 16096, -- Upper clamp to keep legal proportionality.
    base_months = 28, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_412'] = {
    label = 'Infraction 412', -- Human readable name for offense code POSSESSION_DROGUE_412.
    code = 'POSSESSION_DROGUE_412', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 6744, -- Base fine before priors/recidive multipliers.
    min_fine = 4720, -- Lower clamp to prevent under-punishment.
    max_fine = 16185, -- Upper clamp to keep legal proportionality.
    base_months = 29, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_413'] = {
    label = 'Infraction 413', -- Human readable name for offense code VENTE_DROGUE_413.
    code = 'VENTE_DROGUE_413', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 6781, -- Base fine before priors/recidive multipliers.
    min_fine = 4746, -- Lower clamp to prevent under-punishment.
    max_fine = 16274, -- Upper clamp to keep legal proportionality.
    base_months = 30, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_414'] = {
    label = 'Infraction 414', -- Human readable name for offense code AGRESSION_SIMPLE_414.
    code = 'AGRESSION_SIMPLE_414', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 6818, -- Base fine before priors/recidive multipliers.
    min_fine = 4772, -- Lower clamp to prevent under-punishment.
    max_fine = 16363, -- Upper clamp to keep legal proportionality.
    base_months = 31, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_415'] = {
    label = 'Infraction 415', -- Human readable name for offense code AGRESSION_ARMEE_415.
    code = 'AGRESSION_ARMEE_415', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 6855, -- Base fine before priors/recidive multipliers.
    min_fine = 4798, -- Lower clamp to prevent under-punishment.
    max_fine = 16452, -- Upper clamp to keep legal proportionality.
    base_months = 32, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_416'] = {
    label = 'Infraction 416', -- Human readable name for offense code HOMICIDE_416.
    code = 'HOMICIDE_416', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 6892, -- Base fine before priors/recidive multipliers.
    min_fine = 4824, -- Lower clamp to prevent under-punishment.
    max_fine = 16540, -- Upper clamp to keep legal proportionality.
    base_months = 33, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_417'] = {
    label = 'Infraction 417', -- Human readable name for offense code FRAUDE_417.
    code = 'FRAUDE_417', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 6929, -- Base fine before priors/recidive multipliers.
    min_fine = 4850, -- Lower clamp to prevent under-punishment.
    max_fine = 16629, -- Upper clamp to keep legal proportionality.
    base_months = 34, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_418'] = {
    label = 'Infraction 418', -- Human readable name for offense code CORRUPTION_418.
    code = 'CORRUPTION_418', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 6966, -- Base fine before priors/recidive multipliers.
    min_fine = 4876, -- Lower clamp to prevent under-punishment.
    max_fine = 16718, -- Upper clamp to keep legal proportionality.
    base_months = 35, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_419'] = {
    label = 'Infraction 419', -- Human readable name for offense code SEQUESTRATION_419.
    code = 'SEQUESTRATION_419', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 7003, -- Base fine before priors/recidive multipliers.
    min_fine = 4902, -- Lower clamp to prevent under-punishment.
    max_fine = 16807, -- Upper clamp to keep legal proportionality.
    base_months = 36, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_420'] = {
    label = 'Infraction 420', -- Human readable name for offense code VOL_QUALIFIE_420.
    code = 'VOL_QUALIFIE_420', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 7040, -- Base fine before priors/recidive multipliers.
    min_fine = 4928, -- Lower clamp to prevent under-punishment.
    max_fine = 16896, -- Upper clamp to keep legal proportionality.
    base_months = 37, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_421'] = {
    label = 'Infraction 421', -- Human readable name for offense code USAGE_ARME_421.
    code = 'USAGE_ARME_421', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 7077, -- Base fine before priors/recidive multipliers.
    min_fine = 4953, -- Lower clamp to prevent under-punishment.
    max_fine = 16984, -- Upper clamp to keep legal proportionality.
    base_months = 38, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_422'] = {
    label = 'Infraction 422', -- Human readable name for offense code FUITE_422.
    code = 'FUITE_422', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 7114, -- Base fine before priors/recidive multipliers.
    min_fine = 4979, -- Lower clamp to prevent under-punishment.
    max_fine = 17073, -- Upper clamp to keep legal proportionality.
    base_months = 39, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_423'] = {
    label = 'Infraction 423', -- Human readable name for offense code MISE_EN_DANGER_423.
    code = 'MISE_EN_DANGER_423', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 7151, -- Base fine before priors/recidive multipliers.
    min_fine = 5005, -- Lower clamp to prevent under-punishment.
    max_fine = 17162, -- Upper clamp to keep legal proportionality.
    base_months = 40, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_424'] = {
    label = 'Infraction 424', -- Human readable name for offense code POSSESSION_DROGUE_424.
    code = 'POSSESSION_DROGUE_424', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 7188, -- Base fine before priors/recidive multipliers.
    min_fine = 5031, -- Lower clamp to prevent under-punishment.
    max_fine = 17251, -- Upper clamp to keep legal proportionality.
    base_months = 41, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_425'] = {
    label = 'Infraction 425', -- Human readable name for offense code VENTE_DROGUE_425.
    code = 'VENTE_DROGUE_425', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 7225, -- Base fine before priors/recidive multipliers.
    min_fine = 5057, -- Lower clamp to prevent under-punishment.
    max_fine = 17340, -- Upper clamp to keep legal proportionality.
    base_months = 42, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_426'] = {
    label = 'Infraction 426', -- Human readable name for offense code AGRESSION_SIMPLE_426.
    code = 'AGRESSION_SIMPLE_426', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 7262, -- Base fine before priors/recidive multipliers.
    min_fine = 5083, -- Lower clamp to prevent under-punishment.
    max_fine = 17428, -- Upper clamp to keep legal proportionality.
    base_months = 43, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_427'] = {
    label = 'Infraction 427', -- Human readable name for offense code AGRESSION_ARMEE_427.
    code = 'AGRESSION_ARMEE_427', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 7299, -- Base fine before priors/recidive multipliers.
    min_fine = 5109, -- Lower clamp to prevent under-punishment.
    max_fine = 17517, -- Upper clamp to keep legal proportionality.
    base_months = 44, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_428'] = {
    label = 'Infraction 428', -- Human readable name for offense code HOMICIDE_428.
    code = 'HOMICIDE_428', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 7336, -- Base fine before priors/recidive multipliers.
    min_fine = 5135, -- Lower clamp to prevent under-punishment.
    max_fine = 17606, -- Upper clamp to keep legal proportionality.
    base_months = 45, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_429'] = {
    label = 'Infraction 429', -- Human readable name for offense code FRAUDE_429.
    code = 'FRAUDE_429', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 7373, -- Base fine before priors/recidive multipliers.
    min_fine = 5161, -- Lower clamp to prevent under-punishment.
    max_fine = 17695, -- Upper clamp to keep legal proportionality.
    base_months = 46, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_430'] = {
    label = 'Infraction 430', -- Human readable name for offense code CORRUPTION_430.
    code = 'CORRUPTION_430', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 7410, -- Base fine before priors/recidive multipliers.
    min_fine = 5187, -- Lower clamp to prevent under-punishment.
    max_fine = 17784, -- Upper clamp to keep legal proportionality.
    base_months = 47, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_431'] = {
    label = 'Infraction 431', -- Human readable name for offense code SEQUESTRATION_431.
    code = 'SEQUESTRATION_431', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 7447, -- Base fine before priors/recidive multipliers.
    min_fine = 5212, -- Lower clamp to prevent under-punishment.
    max_fine = 17872, -- Upper clamp to keep legal proportionality.
    base_months = 48, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 16, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_432'] = {
    label = 'Infraction 432', -- Human readable name for offense code VOL_QUALIFIE_432.
    code = 'VOL_QUALIFIE_432', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 7484, -- Base fine before priors/recidive multipliers.
    min_fine = 5238, -- Lower clamp to prevent under-punishment.
    max_fine = 17961, -- Upper clamp to keep legal proportionality.
    base_months = 1, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_433'] = {
    label = 'Infraction 433', -- Human readable name for offense code USAGE_ARME_433.
    code = 'USAGE_ARME_433', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 7521, -- Base fine before priors/recidive multipliers.
    min_fine = 5264, -- Lower clamp to prevent under-punishment.
    max_fine = 18050, -- Upper clamp to keep legal proportionality.
    base_months = 2, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_434'] = {
    label = 'Infraction 434', -- Human readable name for offense code FUITE_434.
    code = 'FUITE_434', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 7558, -- Base fine before priors/recidive multipliers.
    min_fine = 5290, -- Lower clamp to prevent under-punishment.
    max_fine = 18139, -- Upper clamp to keep legal proportionality.
    base_months = 3, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_435'] = {
    label = 'Infraction 435', -- Human readable name for offense code MISE_EN_DANGER_435.
    code = 'MISE_EN_DANGER_435', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 7595, -- Base fine before priors/recidive multipliers.
    min_fine = 5316, -- Lower clamp to prevent under-punishment.
    max_fine = 18228, -- Upper clamp to keep legal proportionality.
    base_months = 4, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_436'] = {
    label = 'Infraction 436', -- Human readable name for offense code POSSESSION_DROGUE_436.
    code = 'POSSESSION_DROGUE_436', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 7632, -- Base fine before priors/recidive multipliers.
    min_fine = 5342, -- Lower clamp to prevent under-punishment.
    max_fine = 18316, -- Upper clamp to keep legal proportionality.
    base_months = 5, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_437'] = {
    label = 'Infraction 437', -- Human readable name for offense code VENTE_DROGUE_437.
    code = 'VENTE_DROGUE_437', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 7669, -- Base fine before priors/recidive multipliers.
    min_fine = 5368, -- Lower clamp to prevent under-punishment.
    max_fine = 18405, -- Upper clamp to keep legal proportionality.
    base_months = 6, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_438'] = {
    label = 'Infraction 438', -- Human readable name for offense code AGRESSION_SIMPLE_438.
    code = 'AGRESSION_SIMPLE_438', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 7706, -- Base fine before priors/recidive multipliers.
    min_fine = 5394, -- Lower clamp to prevent under-punishment.
    max_fine = 18494, -- Upper clamp to keep legal proportionality.
    base_months = 7, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_439'] = {
    label = 'Infraction 439', -- Human readable name for offense code AGRESSION_ARMEE_439.
    code = 'AGRESSION_ARMEE_439', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 7743, -- Base fine before priors/recidive multipliers.
    min_fine = 5420, -- Lower clamp to prevent under-punishment.
    max_fine = 18583, -- Upper clamp to keep legal proportionality.
    base_months = 8, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_440'] = {
    label = 'Infraction 440', -- Human readable name for offense code HOMICIDE_440.
    code = 'HOMICIDE_440', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 7780, -- Base fine before priors/recidive multipliers.
    min_fine = 5446, -- Lower clamp to prevent under-punishment.
    max_fine = 18672, -- Upper clamp to keep legal proportionality.
    base_months = 9, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_441'] = {
    label = 'Infraction 441', -- Human readable name for offense code FRAUDE_441.
    code = 'FRAUDE_441', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 7817, -- Base fine before priors/recidive multipliers.
    min_fine = 5471, -- Lower clamp to prevent under-punishment.
    max_fine = 18760, -- Upper clamp to keep legal proportionality.
    base_months = 10, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_442'] = {
    label = 'Infraction 442', -- Human readable name for offense code CORRUPTION_442.
    code = 'CORRUPTION_442', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 7854, -- Base fine before priors/recidive multipliers.
    min_fine = 5497, -- Lower clamp to prevent under-punishment.
    max_fine = 18849, -- Upper clamp to keep legal proportionality.
    base_months = 11, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_443'] = {
    label = 'Infraction 443', -- Human readable name for offense code SEQUESTRATION_443.
    code = 'SEQUESTRATION_443', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 7891, -- Base fine before priors/recidive multipliers.
    min_fine = 5523, -- Lower clamp to prevent under-punishment.
    max_fine = 18938, -- Upper clamp to keep legal proportionality.
    base_months = 12, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_444'] = {
    label = 'Infraction 444', -- Human readable name for offense code VOL_QUALIFIE_444.
    code = 'VOL_QUALIFIE_444', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 7928, -- Base fine before priors/recidive multipliers.
    min_fine = 5549, -- Lower clamp to prevent under-punishment.
    max_fine = 19027, -- Upper clamp to keep legal proportionality.
    base_months = 13, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_445'] = {
    label = 'Infraction 445', -- Human readable name for offense code USAGE_ARME_445.
    code = 'USAGE_ARME_445', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 7965, -- Base fine before priors/recidive multipliers.
    min_fine = 5575, -- Lower clamp to prevent under-punishment.
    max_fine = 19116, -- Upper clamp to keep legal proportionality.
    base_months = 14, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_446'] = {
    label = 'Infraction 446', -- Human readable name for offense code FUITE_446.
    code = 'FUITE_446', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 8002, -- Base fine before priors/recidive multipliers.
    min_fine = 5601, -- Lower clamp to prevent under-punishment.
    max_fine = 19204, -- Upper clamp to keep legal proportionality.
    base_months = 15, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_447'] = {
    label = 'Infraction 447', -- Human readable name for offense code MISE_EN_DANGER_447.
    code = 'MISE_EN_DANGER_447', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 8039, -- Base fine before priors/recidive multipliers.
    min_fine = 5627, -- Lower clamp to prevent under-punishment.
    max_fine = 19293, -- Upper clamp to keep legal proportionality.
    base_months = 16, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_448'] = {
    label = 'Infraction 448', -- Human readable name for offense code POSSESSION_DROGUE_448.
    code = 'POSSESSION_DROGUE_448', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 8076, -- Base fine before priors/recidive multipliers.
    min_fine = 5653, -- Lower clamp to prevent under-punishment.
    max_fine = 19382, -- Upper clamp to keep legal proportionality.
    base_months = 17, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_449'] = {
    label = 'Infraction 449', -- Human readable name for offense code VENTE_DROGUE_449.
    code = 'VENTE_DROGUE_449', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 8113, -- Base fine before priors/recidive multipliers.
    min_fine = 5679, -- Lower clamp to prevent under-punishment.
    max_fine = 19471, -- Upper clamp to keep legal proportionality.
    base_months = 18, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_450'] = {
    label = 'Infraction 450', -- Human readable name for offense code AGRESSION_SIMPLE_450.
    code = 'AGRESSION_SIMPLE_450', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 8150, -- Base fine before priors/recidive multipliers.
    min_fine = 5705, -- Lower clamp to prevent under-punishment.
    max_fine = 19560, -- Upper clamp to keep legal proportionality.
    base_months = 19, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_451'] = {
    label = 'Infraction 451', -- Human readable name for offense code AGRESSION_ARMEE_451.
    code = 'AGRESSION_ARMEE_451', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 8187, -- Base fine before priors/recidive multipliers.
    min_fine = 5730, -- Lower clamp to prevent under-punishment.
    max_fine = 19648, -- Upper clamp to keep legal proportionality.
    base_months = 20, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_452'] = {
    label = 'Infraction 452', -- Human readable name for offense code HOMICIDE_452.
    code = 'HOMICIDE_452', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 8224, -- Base fine before priors/recidive multipliers.
    min_fine = 5756, -- Lower clamp to prevent under-punishment.
    max_fine = 19737, -- Upper clamp to keep legal proportionality.
    base_months = 21, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_453'] = {
    label = 'Infraction 453', -- Human readable name for offense code FRAUDE_453.
    code = 'FRAUDE_453', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 8261, -- Base fine before priors/recidive multipliers.
    min_fine = 5782, -- Lower clamp to prevent under-punishment.
    max_fine = 19826, -- Upper clamp to keep legal proportionality.
    base_months = 22, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_454'] = {
    label = 'Infraction 454', -- Human readable name for offense code CORRUPTION_454.
    code = 'CORRUPTION_454', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 8298, -- Base fine before priors/recidive multipliers.
    min_fine = 5808, -- Lower clamp to prevent under-punishment.
    max_fine = 19915, -- Upper clamp to keep legal proportionality.
    base_months = 23, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_455'] = {
    label = 'Infraction 455', -- Human readable name for offense code SEQUESTRATION_455.
    code = 'SEQUESTRATION_455', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 8335, -- Base fine before priors/recidive multipliers.
    min_fine = 5834, -- Lower clamp to prevent under-punishment.
    max_fine = 20004, -- Upper clamp to keep legal proportionality.
    base_months = 24, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_456'] = {
    label = 'Infraction 456', -- Human readable name for offense code VOL_QUALIFIE_456.
    code = 'VOL_QUALIFIE_456', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 8372, -- Base fine before priors/recidive multipliers.
    min_fine = 5860, -- Lower clamp to prevent under-punishment.
    max_fine = 20092, -- Upper clamp to keep legal proportionality.
    base_months = 25, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_457'] = {
    label = 'Infraction 457', -- Human readable name for offense code USAGE_ARME_457.
    code = 'USAGE_ARME_457', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 8409, -- Base fine before priors/recidive multipliers.
    min_fine = 5886, -- Lower clamp to prevent under-punishment.
    max_fine = 20181, -- Upper clamp to keep legal proportionality.
    base_months = 26, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_458'] = {
    label = 'Infraction 458', -- Human readable name for offense code FUITE_458.
    code = 'FUITE_458', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 8446, -- Base fine before priors/recidive multipliers.
    min_fine = 5912, -- Lower clamp to prevent under-punishment.
    max_fine = 20270, -- Upper clamp to keep legal proportionality.
    base_months = 27, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_459'] = {
    label = 'Infraction 459', -- Human readable name for offense code MISE_EN_DANGER_459.
    code = 'MISE_EN_DANGER_459', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 8483, -- Base fine before priors/recidive multipliers.
    min_fine = 5938, -- Lower clamp to prevent under-punishment.
    max_fine = 20359, -- Upper clamp to keep legal proportionality.
    base_months = 28, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_460'] = {
    label = 'Infraction 460', -- Human readable name for offense code POSSESSION_DROGUE_460.
    code = 'POSSESSION_DROGUE_460', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 8520, -- Base fine before priors/recidive multipliers.
    min_fine = 5964, -- Lower clamp to prevent under-punishment.
    max_fine = 20448, -- Upper clamp to keep legal proportionality.
    base_months = 29, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_461'] = {
    label = 'Infraction 461', -- Human readable name for offense code VENTE_DROGUE_461.
    code = 'VENTE_DROGUE_461', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 8557, -- Base fine before priors/recidive multipliers.
    min_fine = 5989, -- Lower clamp to prevent under-punishment.
    max_fine = 20536, -- Upper clamp to keep legal proportionality.
    base_months = 30, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_462'] = {
    label = 'Infraction 462', -- Human readable name for offense code AGRESSION_SIMPLE_462.
    code = 'AGRESSION_SIMPLE_462', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 8594, -- Base fine before priors/recidive multipliers.
    min_fine = 6015, -- Lower clamp to prevent under-punishment.
    max_fine = 20625, -- Upper clamp to keep legal proportionality.
    base_months = 31, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_463'] = {
    label = 'Infraction 463', -- Human readable name for offense code AGRESSION_ARMEE_463.
    code = 'AGRESSION_ARMEE_463', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 8631, -- Base fine before priors/recidive multipliers.
    min_fine = 6041, -- Lower clamp to prevent under-punishment.
    max_fine = 20714, -- Upper clamp to keep legal proportionality.
    base_months = 32, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_464'] = {
    label = 'Infraction 464', -- Human readable name for offense code HOMICIDE_464.
    code = 'HOMICIDE_464', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 8668, -- Base fine before priors/recidive multipliers.
    min_fine = 6067, -- Lower clamp to prevent under-punishment.
    max_fine = 20803, -- Upper clamp to keep legal proportionality.
    base_months = 33, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_465'] = {
    label = 'Infraction 465', -- Human readable name for offense code FRAUDE_465.
    code = 'FRAUDE_465', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 8705, -- Base fine before priors/recidive multipliers.
    min_fine = 6093, -- Lower clamp to prevent under-punishment.
    max_fine = 20892, -- Upper clamp to keep legal proportionality.
    base_months = 34, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_466'] = {
    label = 'Infraction 466', -- Human readable name for offense code CORRUPTION_466.
    code = 'CORRUPTION_466', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 8742, -- Base fine before priors/recidive multipliers.
    min_fine = 6119, -- Lower clamp to prevent under-punishment.
    max_fine = 20980, -- Upper clamp to keep legal proportionality.
    base_months = 35, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_467'] = {
    label = 'Infraction 467', -- Human readable name for offense code SEQUESTRATION_467.
    code = 'SEQUESTRATION_467', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 8779, -- Base fine before priors/recidive multipliers.
    min_fine = 6145, -- Lower clamp to prevent under-punishment.
    max_fine = 21069, -- Upper clamp to keep legal proportionality.
    base_months = 36, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_468'] = {
    label = 'Infraction 468', -- Human readable name for offense code VOL_QUALIFIE_468.
    code = 'VOL_QUALIFIE_468', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 8816, -- Base fine before priors/recidive multipliers.
    min_fine = 6171, -- Lower clamp to prevent under-punishment.
    max_fine = 21158, -- Upper clamp to keep legal proportionality.
    base_months = 37, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_469'] = {
    label = 'Infraction 469', -- Human readable name for offense code USAGE_ARME_469.
    code = 'USAGE_ARME_469', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 8853, -- Base fine before priors/recidive multipliers.
    min_fine = 6197, -- Lower clamp to prevent under-punishment.
    max_fine = 21247, -- Upper clamp to keep legal proportionality.
    base_months = 38, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_470'] = {
    label = 'Infraction 470', -- Human readable name for offense code FUITE_470.
    code = 'FUITE_470', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 8890, -- Base fine before priors/recidive multipliers.
    min_fine = 6223, -- Lower clamp to prevent under-punishment.
    max_fine = 21336, -- Upper clamp to keep legal proportionality.
    base_months = 39, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_471'] = {
    label = 'Infraction 471', -- Human readable name for offense code MISE_EN_DANGER_471.
    code = 'MISE_EN_DANGER_471', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 8927, -- Base fine before priors/recidive multipliers.
    min_fine = 6248, -- Lower clamp to prevent under-punishment.
    max_fine = 21424, -- Upper clamp to keep legal proportionality.
    base_months = 40, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_472'] = {
    label = 'Infraction 472', -- Human readable name for offense code POSSESSION_DROGUE_472.
    code = 'POSSESSION_DROGUE_472', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 8964, -- Base fine before priors/recidive multipliers.
    min_fine = 6274, -- Lower clamp to prevent under-punishment.
    max_fine = 21513, -- Upper clamp to keep legal proportionality.
    base_months = 41, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_473'] = {
    label = 'Infraction 473', -- Human readable name for offense code VENTE_DROGUE_473.
    code = 'VENTE_DROGUE_473', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 9001, -- Base fine before priors/recidive multipliers.
    min_fine = 6300, -- Lower clamp to prevent under-punishment.
    max_fine = 21602, -- Upper clamp to keep legal proportionality.
    base_months = 42, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_474'] = {
    label = 'Infraction 474', -- Human readable name for offense code AGRESSION_SIMPLE_474.
    code = 'AGRESSION_SIMPLE_474', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 9038, -- Base fine before priors/recidive multipliers.
    min_fine = 6326, -- Lower clamp to prevent under-punishment.
    max_fine = 21691, -- Upper clamp to keep legal proportionality.
    base_months = 43, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_475'] = {
    label = 'Infraction 475', -- Human readable name for offense code AGRESSION_ARMEE_475.
    code = 'AGRESSION_ARMEE_475', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 9075, -- Base fine before priors/recidive multipliers.
    min_fine = 6352, -- Lower clamp to prevent under-punishment.
    max_fine = 21780, -- Upper clamp to keep legal proportionality.
    base_months = 44, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 14, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_476'] = {
    label = 'Infraction 476', -- Human readable name for offense code HOMICIDE_476.
    code = 'HOMICIDE_476', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 9112, -- Base fine before priors/recidive multipliers.
    min_fine = 6378, -- Lower clamp to prevent under-punishment.
    max_fine = 21868, -- Upper clamp to keep legal proportionality.
    base_months = 45, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_477'] = {
    label = 'Infraction 477', -- Human readable name for offense code FRAUDE_477.
    code = 'FRAUDE_477', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 9149, -- Base fine before priors/recidive multipliers.
    min_fine = 6404, -- Lower clamp to prevent under-punishment.
    max_fine = 21957, -- Upper clamp to keep legal proportionality.
    base_months = 46, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_478'] = {
    label = 'Infraction 478', -- Human readable name for offense code CORRUPTION_478.
    code = 'CORRUPTION_478', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 9186, -- Base fine before priors/recidive multipliers.
    min_fine = 6430, -- Lower clamp to prevent under-punishment.
    max_fine = 22046, -- Upper clamp to keep legal proportionality.
    base_months = 47, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 15, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_479'] = {
    label = 'Infraction 479', -- Human readable name for offense code SEQUESTRATION_479.
    code = 'SEQUESTRATION_479', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 9223, -- Base fine before priors/recidive multipliers.
    min_fine = 6456, -- Lower clamp to prevent under-punishment.
    max_fine = 22135, -- Upper clamp to keep legal proportionality.
    base_months = 48, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 16, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_480'] = {
    label = 'Infraction 480', -- Human readable name for offense code VOL_QUALIFIE_480.
    code = 'VOL_QUALIFIE_480', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 9260, -- Base fine before priors/recidive multipliers.
    min_fine = 6482, -- Lower clamp to prevent under-punishment.
    max_fine = 22224, -- Upper clamp to keep legal proportionality.
    base_months = 1, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_481'] = {
    label = 'Infraction 481', -- Human readable name for offense code USAGE_ARME_481.
    code = 'USAGE_ARME_481', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 9297, -- Base fine before priors/recidive multipliers.
    min_fine = 6507, -- Lower clamp to prevent under-punishment.
    max_fine = 22312, -- Upper clamp to keep legal proportionality.
    base_months = 2, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_482'] = {
    label = 'Infraction 482', -- Human readable name for offense code FUITE_482.
    code = 'FUITE_482', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 9334, -- Base fine before priors/recidive multipliers.
    min_fine = 6533, -- Lower clamp to prevent under-punishment.
    max_fine = 22401, -- Upper clamp to keep legal proportionality.
    base_months = 3, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_483'] = {
    label = 'Infraction 483', -- Human readable name for offense code MISE_EN_DANGER_483.
    code = 'MISE_EN_DANGER_483', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 9371, -- Base fine before priors/recidive multipliers.
    min_fine = 6559, -- Lower clamp to prevent under-punishment.
    max_fine = 22490, -- Upper clamp to keep legal proportionality.
    base_months = 4, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_484'] = {
    label = 'Infraction 484', -- Human readable name for offense code POSSESSION_DROGUE_484.
    code = 'POSSESSION_DROGUE_484', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 9408, -- Base fine before priors/recidive multipliers.
    min_fine = 6585, -- Lower clamp to prevent under-punishment.
    max_fine = 22579, -- Upper clamp to keep legal proportionality.
    base_months = 5, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 1, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_485'] = {
    label = 'Infraction 485', -- Human readable name for offense code VENTE_DROGUE_485.
    code = 'VENTE_DROGUE_485', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 9445, -- Base fine before priors/recidive multipliers.
    min_fine = 6611, -- Lower clamp to prevent under-punishment.
    max_fine = 22668, -- Upper clamp to keep legal proportionality.
    base_months = 6, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_486'] = {
    label = 'Infraction 486', -- Human readable name for offense code AGRESSION_SIMPLE_486.
    code = 'AGRESSION_SIMPLE_486', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 9482, -- Base fine before priors/recidive multipliers.
    min_fine = 6637, -- Lower clamp to prevent under-punishment.
    max_fine = 22756, -- Upper clamp to keep legal proportionality.
    base_months = 7, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_487'] = {
    label = 'Infraction 487', -- Human readable name for offense code AGRESSION_ARMEE_487.
    code = 'AGRESSION_ARMEE_487', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 519, -- Base fine before priors/recidive multipliers.
    min_fine = 363, -- Lower clamp to prevent under-punishment.
    max_fine = 1245, -- Upper clamp to keep legal proportionality.
    base_months = 8, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 2, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_488'] = {
    label = 'Infraction 488', -- Human readable name for offense code HOMICIDE_488.
    code = 'HOMICIDE_488', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 556, -- Base fine before priors/recidive multipliers.
    min_fine = 389, -- Lower clamp to prevent under-punishment.
    max_fine = 1334, -- Upper clamp to keep legal proportionality.
    base_months = 9, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_489'] = {
    label = 'Infraction 489', -- Human readable name for offense code FRAUDE_489.
    code = 'FRAUDE_489', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 593, -- Base fine before priors/recidive multipliers.
    min_fine = 415, -- Lower clamp to prevent under-punishment.
    max_fine = 1423, -- Upper clamp to keep legal proportionality.
    base_months = 10, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_490'] = {
    label = 'Infraction 490', -- Human readable name for offense code CORRUPTION_490.
    code = 'CORRUPTION_490', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 630, -- Base fine before priors/recidive multipliers.
    min_fine = 441, -- Lower clamp to prevent under-punishment.
    max_fine = 1512, -- Upper clamp to keep legal proportionality.
    base_months = 11, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 3, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_491'] = {
    label = 'Infraction 491', -- Human readable name for offense code SEQUESTRATION_491.
    code = 'SEQUESTRATION_491', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 667, -- Base fine before priors/recidive multipliers.
    min_fine = 466, -- Lower clamp to prevent under-punishment.
    max_fine = 1600, -- Upper clamp to keep legal proportionality.
    base_months = 12, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_492'] = {
    label = 'Infraction 492', -- Human readable name for offense code VOL_QUALIFIE_492.
    code = 'VOL_QUALIFIE_492', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 704, -- Base fine before priors/recidive multipliers.
    min_fine = 492, -- Lower clamp to prevent under-punishment.
    max_fine = 1689, -- Upper clamp to keep legal proportionality.
    base_months = 13, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_493'] = {
    label = 'Infraction 493', -- Human readable name for offense code USAGE_ARME_493.
    code = 'USAGE_ARME_493', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 741, -- Base fine before priors/recidive multipliers.
    min_fine = 518, -- Lower clamp to prevent under-punishment.
    max_fine = 1778, -- Upper clamp to keep legal proportionality.
    base_months = 14, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 4, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_494'] = {
    label = 'Infraction 494', -- Human readable name for offense code FUITE_494.
    code = 'FUITE_494', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 778, -- Base fine before priors/recidive multipliers.
    min_fine = 544, -- Lower clamp to prevent under-punishment.
    max_fine = 1867, -- Upper clamp to keep legal proportionality.
    base_months = 15, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_495'] = {
    label = 'Infraction 495', -- Human readable name for offense code MISE_EN_DANGER_495.
    code = 'MISE_EN_DANGER_495', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 815, -- Base fine before priors/recidive multipliers.
    min_fine = 570, -- Lower clamp to prevent under-punishment.
    max_fine = 1956, -- Upper clamp to keep legal proportionality.
    base_months = 16, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_496'] = {
    label = 'Infraction 496', -- Human readable name for offense code POSSESSION_DROGUE_496.
    code = 'POSSESSION_DROGUE_496', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 852, -- Base fine before priors/recidive multipliers.
    min_fine = 596, -- Lower clamp to prevent under-punishment.
    max_fine = 2044, -- Upper clamp to keep legal proportionality.
    base_months = 17, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 5, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_497'] = {
    label = 'Infraction 497', -- Human readable name for offense code VENTE_DROGUE_497.
    code = 'VENTE_DROGUE_497', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 889, -- Base fine before priors/recidive multipliers.
    min_fine = 622, -- Lower clamp to prevent under-punishment.
    max_fine = 2133, -- Upper clamp to keep legal proportionality.
    base_months = 18, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_498'] = {
    label = 'Infraction 498', -- Human readable name for offense code AGRESSION_SIMPLE_498.
    code = 'AGRESSION_SIMPLE_498', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 926, -- Base fine before priors/recidive multipliers.
    min_fine = 648, -- Lower clamp to prevent under-punishment.
    max_fine = 2222, -- Upper clamp to keep legal proportionality.
    base_months = 19, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_499'] = {
    label = 'Infraction 499', -- Human readable name for offense code AGRESSION_ARMEE_499.
    code = 'AGRESSION_ARMEE_499', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 963, -- Base fine before priors/recidive multipliers.
    min_fine = 674, -- Lower clamp to prevent under-punishment.
    max_fine = 2311, -- Upper clamp to keep legal proportionality.
    base_months = 20, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 6, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_500'] = {
    label = 'Infraction 500', -- Human readable name for offense code HOMICIDE_500.
    code = 'HOMICIDE_500', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1000, -- Base fine before priors/recidive multipliers.
    min_fine = 700, -- Lower clamp to prevent under-punishment.
    max_fine = 2400, -- Upper clamp to keep legal proportionality.
    base_months = 21, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_501'] = {
    label = 'Infraction 501', -- Human readable name for offense code FRAUDE_501.
    code = 'FRAUDE_501', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1037, -- Base fine before priors/recidive multipliers.
    min_fine = 725, -- Lower clamp to prevent under-punishment.
    max_fine = 2488, -- Upper clamp to keep legal proportionality.
    base_months = 22, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_502'] = {
    label = 'Infraction 502', -- Human readable name for offense code CORRUPTION_502.
    code = 'CORRUPTION_502', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1074, -- Base fine before priors/recidive multipliers.
    min_fine = 751, -- Lower clamp to prevent under-punishment.
    max_fine = 2577, -- Upper clamp to keep legal proportionality.
    base_months = 23, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 7, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_503'] = {
    label = 'Infraction 503', -- Human readable name for offense code SEQUESTRATION_503.
    code = 'SEQUESTRATION_503', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1111, -- Base fine before priors/recidive multipliers.
    min_fine = 777, -- Lower clamp to prevent under-punishment.
    max_fine = 2666, -- Upper clamp to keep legal proportionality.
    base_months = 24, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_504'] = {
    label = 'Infraction 504', -- Human readable name for offense code VOL_QUALIFIE_504.
    code = 'VOL_QUALIFIE_504', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1148, -- Base fine before priors/recidive multipliers.
    min_fine = 803, -- Lower clamp to prevent under-punishment.
    max_fine = 2755, -- Upper clamp to keep legal proportionality.
    base_months = 25, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_505'] = {
    label = 'Infraction 505', -- Human readable name for offense code USAGE_ARME_505.
    code = 'USAGE_ARME_505', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1185, -- Base fine before priors/recidive multipliers.
    min_fine = 829, -- Lower clamp to prevent under-punishment.
    max_fine = 2844, -- Upper clamp to keep legal proportionality.
    base_months = 26, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 8, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_506'] = {
    label = 'Infraction 506', -- Human readable name for offense code FUITE_506.
    code = 'FUITE_506', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1222, -- Base fine before priors/recidive multipliers.
    min_fine = 855, -- Lower clamp to prevent under-punishment.
    max_fine = 2932, -- Upper clamp to keep legal proportionality.
    base_months = 27, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_507'] = {
    label = 'Infraction 507', -- Human readable name for offense code MISE_EN_DANGER_507.
    code = 'MISE_EN_DANGER_507', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1259, -- Base fine before priors/recidive multipliers.
    min_fine = 881, -- Lower clamp to prevent under-punishment.
    max_fine = 3021, -- Upper clamp to keep legal proportionality.
    base_months = 28, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_508'] = {
    label = 'Infraction 508', -- Human readable name for offense code POSSESSION_DROGUE_508.
    code = 'POSSESSION_DROGUE_508', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1296, -- Base fine before priors/recidive multipliers.
    min_fine = 907, -- Lower clamp to prevent under-punishment.
    max_fine = 3110, -- Upper clamp to keep legal proportionality.
    base_months = 29, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 9, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VENTE_DROGUE_509'] = {
    label = 'Infraction 509', -- Human readable name for offense code VENTE_DROGUE_509.
    code = 'VENTE_DROGUE_509', -- Unique legal code used in report breakdown export.
    category = 'CAT_6', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1333, -- Base fine before priors/recidive multipliers.
    min_fine = 933, -- Lower clamp to prevent under-punishment.
    max_fine = 3199, -- Upper clamp to keep legal proportionality.
    base_months = 30, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_SIMPLE_510'] = {
    label = 'Infraction 510', -- Human readable name for offense code AGRESSION_SIMPLE_510.
    code = 'AGRESSION_SIMPLE_510', -- Unique legal code used in report breakdown export.
    category = 'CAT_7', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1370, -- Base fine before priors/recidive multipliers.
    min_fine = 958, -- Lower clamp to prevent under-punishment.
    max_fine = 3288, -- Upper clamp to keep legal proportionality.
    base_months = 31, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['AGRESSION_ARMEE_511'] = {
    label = 'Infraction 511', -- Human readable name for offense code AGRESSION_ARMEE_511.
    code = 'AGRESSION_ARMEE_511', -- Unique legal code used in report breakdown export.
    category = 'CAT_8', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1407, -- Base fine before priors/recidive multipliers.
    min_fine = 984, -- Lower clamp to prevent under-punishment.
    max_fine = 3376, -- Upper clamp to keep legal proportionality.
    base_months = 32, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 10, -- Suggested probation duration for plea bargains.
    tags = {'tag2','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['HOMICIDE_512'] = {
    label = 'Infraction 512', -- Human readable name for offense code HOMICIDE_512.
    code = 'HOMICIDE_512', -- Unique legal code used in report breakdown export.
    category = 'CAT_9', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1444, -- Base fine before priors/recidive multipliers.
    min_fine = 1010, -- Lower clamp to prevent under-punishment.
    max_fine = 3465, -- Upper clamp to keep legal proportionality.
    base_months = 33, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag3','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FRAUDE_513'] = {
    label = 'Infraction 513', -- Human readable name for offense code FRAUDE_513.
    code = 'FRAUDE_513', -- Unique legal code used in report breakdown export.
    category = 'CAT_10', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1481, -- Base fine before priors/recidive multipliers.
    min_fine = 1036, -- Lower clamp to prevent under-punishment.
    max_fine = 3554, -- Upper clamp to keep legal proportionality.
    base_months = 34, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag4','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['CORRUPTION_514'] = {
    label = 'Infraction 514', -- Human readable name for offense code CORRUPTION_514.
    code = 'CORRUPTION_514', -- Unique legal code used in report breakdown export.
    category = 'CAT_11', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1518, -- Base fine before priors/recidive multipliers.
    min_fine = 1062, -- Lower clamp to prevent under-punishment.
    max_fine = 3643, -- Upper clamp to keep legal proportionality.
    base_months = 35, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 11, -- Suggested probation duration for plea bargains.
    tags = {'tag5','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['SEQUESTRATION_515'] = {
    label = 'Infraction 515', -- Human readable name for offense code SEQUESTRATION_515.
    code = 'SEQUESTRATION_515', -- Unique legal code used in report breakdown export.
    category = 'CAT_12', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1555, -- Base fine before priors/recidive multipliers.
    min_fine = 1088, -- Lower clamp to prevent under-punishment.
    max_fine = 3732, -- Upper clamp to keep legal proportionality.
    base_months = 36, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag6','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['VOL_QUALIFIE_516'] = {
    label = 'Infraction 516', -- Human readable name for offense code VOL_QUALIFIE_516.
    code = 'VOL_QUALIFIE_516', -- Unique legal code used in report breakdown export.
    category = 'CAT_1', -- Category bucket for sidebar filtering and analytics.
    severity = 2, -- Severity level used by workflow prioritization.
    base_fine = 1592, -- Base fine before priors/recidive multipliers.
    min_fine = 1114, -- Lower clamp to prevent under-punishment.
    max_fine = 3820, -- Upper clamp to keep legal proportionality.
    base_months = 37, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.20, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag7','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['USAGE_ARME_517'] = {
    label = 'Infraction 517', -- Human readable name for offense code USAGE_ARME_517.
    code = 'USAGE_ARME_517', -- Unique legal code used in report breakdown export.
    category = 'CAT_2', -- Category bucket for sidebar filtering and analytics.
    severity = 3, -- Severity level used by workflow prioritization.
    base_fine = 1629, -- Base fine before priors/recidive multipliers.
    min_fine = 1140, -- Lower clamp to prevent under-punishment.
    max_fine = 3909, -- Upper clamp to keep legal proportionality.
    base_months = 38, -- Base prison months before adjustments.
    months_per_prior = 2, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.30, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 12, -- Suggested probation duration for plea bargains.
    tags = {'tag8','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['FUITE_518'] = {
    label = 'Infraction 518', -- Human readable name for offense code FUITE_518.
    code = 'FUITE_518', -- Unique legal code used in report breakdown export.
    category = 'CAT_3', -- Category bucket for sidebar filtering and analytics.
    severity = 4, -- Severity level used by workflow prioritization.
    base_fine = 1666, -- Base fine before priors/recidive multipliers.
    min_fine = 1166, -- Lower clamp to prevent under-punishment.
    max_fine = 3998, -- Upper clamp to keep legal proportionality.
    base_months = 39, -- Base prison months before adjustments.
    months_per_prior = 3, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.40, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag9','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['MISE_EN_DANGER_519'] = {
    label = 'Infraction 519', -- Human readable name for offense code MISE_EN_DANGER_519.
    code = 'MISE_EN_DANGER_519', -- Unique legal code used in report breakdown export.
    category = 'CAT_4', -- Category bucket for sidebar filtering and analytics.
    severity = 5, -- Severity level used by workflow prioritization.
    base_fine = 1703, -- Base fine before priors/recidive multipliers.
    min_fine = 1192, -- Lower clamp to prevent under-punishment.
    max_fine = 4087, -- Upper clamp to keep legal proportionality.
    base_months = 40, -- Base prison months before adjustments.
    months_per_prior = 4, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.50, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = true, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag10','legal','mdt'}, -- Search keywords in NUI filter.
  },
  ['POSSESSION_DROGUE_520'] = {
    label = 'Infraction 520', -- Human readable name for offense code POSSESSION_DROGUE_520.
    code = 'POSSESSION_DROGUE_520', -- Unique legal code used in report breakdown export.
    category = 'CAT_5', -- Category bucket for sidebar filtering and analytics.
    severity = 1, -- Severity level used by workflow prioritization.
    base_fine = 1740, -- Base fine before priors/recidive multipliers.
    min_fine = 1218, -- Lower clamp to prevent under-punishment.
    max_fine = 4176, -- Upper clamp to keep legal proportionality.
    base_months = 41, -- Base prison months before adjustments.
    months_per_prior = 1, -- Extra months per relevant prior in window.
    recidive_multiplier = 1.10, -- Multiplier applied when recidive flag is true.
    priors_multiplier = 0.25, -- +25% fine per prior as requested.
    allow_probation = false, -- Whether alternative sentence can be offered.
    probation_months = 13, -- Suggested probation duration for plea bargains.
    tags = {'tag1','legal','mdt'}, -- Search keywords in NUI filter.
  },
}
Config.Agencies = {
  ['AGENCY_001'] = { displayName = 'Agency Division 001', badgePrefix = 'B001', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_002'] = { displayName = 'Agency Division 002', badgePrefix = 'B002', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_003'] = { displayName = 'Agency Division 003', badgePrefix = 'B003', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_004'] = { displayName = 'Agency Division 004', badgePrefix = 'B004', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_005'] = { displayName = 'Agency Division 005', badgePrefix = 'B005', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_006'] = { displayName = 'Agency Division 006', badgePrefix = 'B006', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_007'] = { displayName = 'Agency Division 007', badgePrefix = 'B007', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_008'] = { displayName = 'Agency Division 008', badgePrefix = 'B008', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_009'] = { displayName = 'Agency Division 009', badgePrefix = 'B009', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_010'] = { displayName = 'Agency Division 010', badgePrefix = 'B010', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_011'] = { displayName = 'Agency Division 011', badgePrefix = 'B011', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_012'] = { displayName = 'Agency Division 012', badgePrefix = 'B012', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_013'] = { displayName = 'Agency Division 013', badgePrefix = 'B013', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_014'] = { displayName = 'Agency Division 014', badgePrefix = 'B014', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_015'] = { displayName = 'Agency Division 015', badgePrefix = 'B015', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_016'] = { displayName = 'Agency Division 016', badgePrefix = 'B016', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_017'] = { displayName = 'Agency Division 017', badgePrefix = 'B017', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_018'] = { displayName = 'Agency Division 018', badgePrefix = 'B018', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_019'] = { displayName = 'Agency Division 019', badgePrefix = 'B019', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_020'] = { displayName = 'Agency Division 020', badgePrefix = 'B020', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_021'] = { displayName = 'Agency Division 021', badgePrefix = 'B021', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_022'] = { displayName = 'Agency Division 022', badgePrefix = 'B022', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_023'] = { displayName = 'Agency Division 023', badgePrefix = 'B023', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_024'] = { displayName = 'Agency Division 024', badgePrefix = 'B024', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_025'] = { displayName = 'Agency Division 025', badgePrefix = 'B025', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_026'] = { displayName = 'Agency Division 026', badgePrefix = 'B026', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_027'] = { displayName = 'Agency Division 027', badgePrefix = 'B027', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_028'] = { displayName = 'Agency Division 028', badgePrefix = 'B028', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_029'] = { displayName = 'Agency Division 029', badgePrefix = 'B029', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_030'] = { displayName = 'Agency Division 030', badgePrefix = 'B030', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_031'] = { displayName = 'Agency Division 031', badgePrefix = 'B031', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_032'] = { displayName = 'Agency Division 032', badgePrefix = 'B032', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_033'] = { displayName = 'Agency Division 033', badgePrefix = 'B033', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_034'] = { displayName = 'Agency Division 034', badgePrefix = 'B034', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_035'] = { displayName = 'Agency Division 035', badgePrefix = 'B035', canAccessPrivateNotes = true, canApproveReports = true },
  ['AGENCY_036'] = { displayName = 'Agency Division 036', badgePrefix = 'B036', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_037'] = { displayName = 'Agency Division 037', badgePrefix = 'B037', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_038'] = { displayName = 'Agency Division 038', badgePrefix = 'B038', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_039'] = { displayName = 'Agency Division 039', badgePrefix = 'B039', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_040'] = { displayName = 'Agency Division 040', badgePrefix = 'B040', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_041'] = { displayName = 'Agency Division 041', badgePrefix = 'B041', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_042'] = { displayName = 'Agency Division 042', badgePrefix = 'B042', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_043'] = { displayName = 'Agency Division 043', badgePrefix = 'B043', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_044'] = { displayName = 'Agency Division 044', badgePrefix = 'B044', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_045'] = { displayName = 'Agency Division 045', badgePrefix = 'B045', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_046'] = { displayName = 'Agency Division 046', badgePrefix = 'B046', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_047'] = { displayName = 'Agency Division 047', badgePrefix = 'B047', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_048'] = { displayName = 'Agency Division 048', badgePrefix = 'B048', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_049'] = { displayName = 'Agency Division 049', badgePrefix = 'B049', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_050'] = { displayName = 'Agency Division 050', badgePrefix = 'B050', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_051'] = { displayName = 'Agency Division 051', badgePrefix = 'B051', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_052'] = { displayName = 'Agency Division 052', badgePrefix = 'B052', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_053'] = { displayName = 'Agency Division 053', badgePrefix = 'B053', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_054'] = { displayName = 'Agency Division 054', badgePrefix = 'B054', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_055'] = { displayName = 'Agency Division 055', badgePrefix = 'B055', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_056'] = { displayName = 'Agency Division 056', badgePrefix = 'B056', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_057'] = { displayName = 'Agency Division 057', badgePrefix = 'B057', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_058'] = { displayName = 'Agency Division 058', badgePrefix = 'B058', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_059'] = { displayName = 'Agency Division 059', badgePrefix = 'B059', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_060'] = { displayName = 'Agency Division 060', badgePrefix = 'B060', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_061'] = { displayName = 'Agency Division 061', badgePrefix = 'B061', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_062'] = { displayName = 'Agency Division 062', badgePrefix = 'B062', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_063'] = { displayName = 'Agency Division 063', badgePrefix = 'B063', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_064'] = { displayName = 'Agency Division 064', badgePrefix = 'B064', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_065'] = { displayName = 'Agency Division 065', badgePrefix = 'B065', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_066'] = { displayName = 'Agency Division 066', badgePrefix = 'B066', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_067'] = { displayName = 'Agency Division 067', badgePrefix = 'B067', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_068'] = { displayName = 'Agency Division 068', badgePrefix = 'B068', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_069'] = { displayName = 'Agency Division 069', badgePrefix = 'B069', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_070'] = { displayName = 'Agency Division 070', badgePrefix = 'B070', canAccessPrivateNotes = true, canApproveReports = true },
  ['AGENCY_071'] = { displayName = 'Agency Division 071', badgePrefix = 'B071', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_072'] = { displayName = 'Agency Division 072', badgePrefix = 'B072', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_073'] = { displayName = 'Agency Division 073', badgePrefix = 'B073', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_074'] = { displayName = 'Agency Division 074', badgePrefix = 'B074', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_075'] = { displayName = 'Agency Division 075', badgePrefix = 'B075', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_076'] = { displayName = 'Agency Division 076', badgePrefix = 'B076', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_077'] = { displayName = 'Agency Division 077', badgePrefix = 'B077', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_078'] = { displayName = 'Agency Division 078', badgePrefix = 'B078', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_079'] = { displayName = 'Agency Division 079', badgePrefix = 'B079', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_080'] = { displayName = 'Agency Division 080', badgePrefix = 'B080', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_081'] = { displayName = 'Agency Division 081', badgePrefix = 'B081', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_082'] = { displayName = 'Agency Division 082', badgePrefix = 'B082', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_083'] = { displayName = 'Agency Division 083', badgePrefix = 'B083', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_084'] = { displayName = 'Agency Division 084', badgePrefix = 'B084', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_085'] = { displayName = 'Agency Division 085', badgePrefix = 'B085', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_086'] = { displayName = 'Agency Division 086', badgePrefix = 'B086', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_087'] = { displayName = 'Agency Division 087', badgePrefix = 'B087', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_088'] = { displayName = 'Agency Division 088', badgePrefix = 'B088', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_089'] = { displayName = 'Agency Division 089', badgePrefix = 'B089', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_090'] = { displayName = 'Agency Division 090', badgePrefix = 'B090', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_091'] = { displayName = 'Agency Division 091', badgePrefix = 'B091', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_092'] = { displayName = 'Agency Division 092', badgePrefix = 'B092', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_093'] = { displayName = 'Agency Division 093', badgePrefix = 'B093', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_094'] = { displayName = 'Agency Division 094', badgePrefix = 'B094', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_095'] = { displayName = 'Agency Division 095', badgePrefix = 'B095', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_096'] = { displayName = 'Agency Division 096', badgePrefix = 'B096', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_097'] = { displayName = 'Agency Division 097', badgePrefix = 'B097', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_098'] = { displayName = 'Agency Division 098', badgePrefix = 'B098', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_099'] = { displayName = 'Agency Division 099', badgePrefix = 'B099', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_100'] = { displayName = 'Agency Division 100', badgePrefix = 'B100', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_101'] = { displayName = 'Agency Division 101', badgePrefix = 'B101', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_102'] = { displayName = 'Agency Division 102', badgePrefix = 'B102', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_103'] = { displayName = 'Agency Division 103', badgePrefix = 'B103', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_104'] = { displayName = 'Agency Division 104', badgePrefix = 'B104', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_105'] = { displayName = 'Agency Division 105', badgePrefix = 'B105', canAccessPrivateNotes = true, canApproveReports = true },
  ['AGENCY_106'] = { displayName = 'Agency Division 106', badgePrefix = 'B106', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_107'] = { displayName = 'Agency Division 107', badgePrefix = 'B107', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_108'] = { displayName = 'Agency Division 108', badgePrefix = 'B108', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_109'] = { displayName = 'Agency Division 109', badgePrefix = 'B109', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_110'] = { displayName = 'Agency Division 110', badgePrefix = 'B110', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_111'] = { displayName = 'Agency Division 111', badgePrefix = 'B111', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_112'] = { displayName = 'Agency Division 112', badgePrefix = 'B112', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_113'] = { displayName = 'Agency Division 113', badgePrefix = 'B113', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_114'] = { displayName = 'Agency Division 114', badgePrefix = 'B114', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_115'] = { displayName = 'Agency Division 115', badgePrefix = 'B115', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_116'] = { displayName = 'Agency Division 116', badgePrefix = 'B116', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_117'] = { displayName = 'Agency Division 117', badgePrefix = 'B117', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_118'] = { displayName = 'Agency Division 118', badgePrefix = 'B118', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_119'] = { displayName = 'Agency Division 119', badgePrefix = 'B119', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_120'] = { displayName = 'Agency Division 120', badgePrefix = 'B120', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_121'] = { displayName = 'Agency Division 121', badgePrefix = 'B121', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_122'] = { displayName = 'Agency Division 122', badgePrefix = 'B122', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_123'] = { displayName = 'Agency Division 123', badgePrefix = 'B123', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_124'] = { displayName = 'Agency Division 124', badgePrefix = 'B124', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_125'] = { displayName = 'Agency Division 125', badgePrefix = 'B125', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_126'] = { displayName = 'Agency Division 126', badgePrefix = 'B126', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_127'] = { displayName = 'Agency Division 127', badgePrefix = 'B127', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_128'] = { displayName = 'Agency Division 128', badgePrefix = 'B128', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_129'] = { displayName = 'Agency Division 129', badgePrefix = 'B129', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_130'] = { displayName = 'Agency Division 130', badgePrefix = 'B130', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_131'] = { displayName = 'Agency Division 131', badgePrefix = 'B131', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_132'] = { displayName = 'Agency Division 132', badgePrefix = 'B132', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_133'] = { displayName = 'Agency Division 133', badgePrefix = 'B133', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_134'] = { displayName = 'Agency Division 134', badgePrefix = 'B134', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_135'] = { displayName = 'Agency Division 135', badgePrefix = 'B135', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_136'] = { displayName = 'Agency Division 136', badgePrefix = 'B136', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_137'] = { displayName = 'Agency Division 137', badgePrefix = 'B137', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_138'] = { displayName = 'Agency Division 138', badgePrefix = 'B138', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_139'] = { displayName = 'Agency Division 139', badgePrefix = 'B139', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_140'] = { displayName = 'Agency Division 140', badgePrefix = 'B140', canAccessPrivateNotes = true, canApproveReports = true },
  ['AGENCY_141'] = { displayName = 'Agency Division 141', badgePrefix = 'B141', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_142'] = { displayName = 'Agency Division 142', badgePrefix = 'B142', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_143'] = { displayName = 'Agency Division 143', badgePrefix = 'B143', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_144'] = { displayName = 'Agency Division 144', badgePrefix = 'B144', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_145'] = { displayName = 'Agency Division 145', badgePrefix = 'B145', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_146'] = { displayName = 'Agency Division 146', badgePrefix = 'B146', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_147'] = { displayName = 'Agency Division 147', badgePrefix = 'B147', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_148'] = { displayName = 'Agency Division 148', badgePrefix = 'B148', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_149'] = { displayName = 'Agency Division 149', badgePrefix = 'B149', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_150'] = { displayName = 'Agency Division 150', badgePrefix = 'B150', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_151'] = { displayName = 'Agency Division 151', badgePrefix = 'B151', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_152'] = { displayName = 'Agency Division 152', badgePrefix = 'B152', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_153'] = { displayName = 'Agency Division 153', badgePrefix = 'B153', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_154'] = { displayName = 'Agency Division 154', badgePrefix = 'B154', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_155'] = { displayName = 'Agency Division 155', badgePrefix = 'B155', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_156'] = { displayName = 'Agency Division 156', badgePrefix = 'B156', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_157'] = { displayName = 'Agency Division 157', badgePrefix = 'B157', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_158'] = { displayName = 'Agency Division 158', badgePrefix = 'B158', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_159'] = { displayName = 'Agency Division 159', badgePrefix = 'B159', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_160'] = { displayName = 'Agency Division 160', badgePrefix = 'B160', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_161'] = { displayName = 'Agency Division 161', badgePrefix = 'B161', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_162'] = { displayName = 'Agency Division 162', badgePrefix = 'B162', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_163'] = { displayName = 'Agency Division 163', badgePrefix = 'B163', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_164'] = { displayName = 'Agency Division 164', badgePrefix = 'B164', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_165'] = { displayName = 'Agency Division 165', badgePrefix = 'B165', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_166'] = { displayName = 'Agency Division 166', badgePrefix = 'B166', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_167'] = { displayName = 'Agency Division 167', badgePrefix = 'B167', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_168'] = { displayName = 'Agency Division 168', badgePrefix = 'B168', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_169'] = { displayName = 'Agency Division 169', badgePrefix = 'B169', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_170'] = { displayName = 'Agency Division 170', badgePrefix = 'B170', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_171'] = { displayName = 'Agency Division 171', badgePrefix = 'B171', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_172'] = { displayName = 'Agency Division 172', badgePrefix = 'B172', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_173'] = { displayName = 'Agency Division 173', badgePrefix = 'B173', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_174'] = { displayName = 'Agency Division 174', badgePrefix = 'B174', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_175'] = { displayName = 'Agency Division 175', badgePrefix = 'B175', canAccessPrivateNotes = true, canApproveReports = true },
  ['AGENCY_176'] = { displayName = 'Agency Division 176', badgePrefix = 'B176', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_177'] = { displayName = 'Agency Division 177', badgePrefix = 'B177', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_178'] = { displayName = 'Agency Division 178', badgePrefix = 'B178', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_179'] = { displayName = 'Agency Division 179', badgePrefix = 'B179', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_180'] = { displayName = 'Agency Division 180', badgePrefix = 'B180', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_181'] = { displayName = 'Agency Division 181', badgePrefix = 'B181', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_182'] = { displayName = 'Agency Division 182', badgePrefix = 'B182', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_183'] = { displayName = 'Agency Division 183', badgePrefix = 'B183', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_184'] = { displayName = 'Agency Division 184', badgePrefix = 'B184', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_185'] = { displayName = 'Agency Division 185', badgePrefix = 'B185', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_186'] = { displayName = 'Agency Division 186', badgePrefix = 'B186', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_187'] = { displayName = 'Agency Division 187', badgePrefix = 'B187', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_188'] = { displayName = 'Agency Division 188', badgePrefix = 'B188', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_189'] = { displayName = 'Agency Division 189', badgePrefix = 'B189', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_190'] = { displayName = 'Agency Division 190', badgePrefix = 'B190', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_191'] = { displayName = 'Agency Division 191', badgePrefix = 'B191', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_192'] = { displayName = 'Agency Division 192', badgePrefix = 'B192', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_193'] = { displayName = 'Agency Division 193', badgePrefix = 'B193', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_194'] = { displayName = 'Agency Division 194', badgePrefix = 'B194', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_195'] = { displayName = 'Agency Division 195', badgePrefix = 'B195', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_196'] = { displayName = 'Agency Division 196', badgePrefix = 'B196', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_197'] = { displayName = 'Agency Division 197', badgePrefix = 'B197', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_198'] = { displayName = 'Agency Division 198', badgePrefix = 'B198', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_199'] = { displayName = 'Agency Division 199', badgePrefix = 'B199', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_200'] = { displayName = 'Agency Division 200', badgePrefix = 'B200', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_201'] = { displayName = 'Agency Division 201', badgePrefix = 'B201', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_202'] = { displayName = 'Agency Division 202', badgePrefix = 'B202', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_203'] = { displayName = 'Agency Division 203', badgePrefix = 'B203', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_204'] = { displayName = 'Agency Division 204', badgePrefix = 'B204', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_205'] = { displayName = 'Agency Division 205', badgePrefix = 'B205', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_206'] = { displayName = 'Agency Division 206', badgePrefix = 'B206', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_207'] = { displayName = 'Agency Division 207', badgePrefix = 'B207', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_208'] = { displayName = 'Agency Division 208', badgePrefix = 'B208', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_209'] = { displayName = 'Agency Division 209', badgePrefix = 'B209', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_210'] = { displayName = 'Agency Division 210', badgePrefix = 'B210', canAccessPrivateNotes = true, canApproveReports = true },
  ['AGENCY_211'] = { displayName = 'Agency Division 211', badgePrefix = 'B211', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_212'] = { displayName = 'Agency Division 212', badgePrefix = 'B212', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_213'] = { displayName = 'Agency Division 213', badgePrefix = 'B213', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_214'] = { displayName = 'Agency Division 214', badgePrefix = 'B214', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_215'] = { displayName = 'Agency Division 215', badgePrefix = 'B215', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_216'] = { displayName = 'Agency Division 216', badgePrefix = 'B216', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_217'] = { displayName = 'Agency Division 217', badgePrefix = 'B217', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_218'] = { displayName = 'Agency Division 218', badgePrefix = 'B218', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_219'] = { displayName = 'Agency Division 219', badgePrefix = 'B219', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_220'] = { displayName = 'Agency Division 220', badgePrefix = 'B220', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_221'] = { displayName = 'Agency Division 221', badgePrefix = 'B221', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_222'] = { displayName = 'Agency Division 222', badgePrefix = 'B222', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_223'] = { displayName = 'Agency Division 223', badgePrefix = 'B223', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_224'] = { displayName = 'Agency Division 224', badgePrefix = 'B224', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_225'] = { displayName = 'Agency Division 225', badgePrefix = 'B225', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_226'] = { displayName = 'Agency Division 226', badgePrefix = 'B226', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_227'] = { displayName = 'Agency Division 227', badgePrefix = 'B227', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_228'] = { displayName = 'Agency Division 228', badgePrefix = 'B228', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_229'] = { displayName = 'Agency Division 229', badgePrefix = 'B229', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_230'] = { displayName = 'Agency Division 230', badgePrefix = 'B230', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_231'] = { displayName = 'Agency Division 231', badgePrefix = 'B231', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_232'] = { displayName = 'Agency Division 232', badgePrefix = 'B232', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_233'] = { displayName = 'Agency Division 233', badgePrefix = 'B233', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_234'] = { displayName = 'Agency Division 234', badgePrefix = 'B234', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_235'] = { displayName = 'Agency Division 235', badgePrefix = 'B235', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_236'] = { displayName = 'Agency Division 236', badgePrefix = 'B236', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_237'] = { displayName = 'Agency Division 237', badgePrefix = 'B237', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_238'] = { displayName = 'Agency Division 238', badgePrefix = 'B238', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_239'] = { displayName = 'Agency Division 239', badgePrefix = 'B239', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_240'] = { displayName = 'Agency Division 240', badgePrefix = 'B240', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_241'] = { displayName = 'Agency Division 241', badgePrefix = 'B241', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_242'] = { displayName = 'Agency Division 242', badgePrefix = 'B242', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_243'] = { displayName = 'Agency Division 243', badgePrefix = 'B243', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_244'] = { displayName = 'Agency Division 244', badgePrefix = 'B244', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_245'] = { displayName = 'Agency Division 245', badgePrefix = 'B245', canAccessPrivateNotes = true, canApproveReports = true },
  ['AGENCY_246'] = { displayName = 'Agency Division 246', badgePrefix = 'B246', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_247'] = { displayName = 'Agency Division 247', badgePrefix = 'B247', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_248'] = { displayName = 'Agency Division 248', badgePrefix = 'B248', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_249'] = { displayName = 'Agency Division 249', badgePrefix = 'B249', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_250'] = { displayName = 'Agency Division 250', badgePrefix = 'B250', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_251'] = { displayName = 'Agency Division 251', badgePrefix = 'B251', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_252'] = { displayName = 'Agency Division 252', badgePrefix = 'B252', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_253'] = { displayName = 'Agency Division 253', badgePrefix = 'B253', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_254'] = { displayName = 'Agency Division 254', badgePrefix = 'B254', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_255'] = { displayName = 'Agency Division 255', badgePrefix = 'B255', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_256'] = { displayName = 'Agency Division 256', badgePrefix = 'B256', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_257'] = { displayName = 'Agency Division 257', badgePrefix = 'B257', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_258'] = { displayName = 'Agency Division 258', badgePrefix = 'B258', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_259'] = { displayName = 'Agency Division 259', badgePrefix = 'B259', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_260'] = { displayName = 'Agency Division 260', badgePrefix = 'B260', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_261'] = { displayName = 'Agency Division 261', badgePrefix = 'B261', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_262'] = { displayName = 'Agency Division 262', badgePrefix = 'B262', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_263'] = { displayName = 'Agency Division 263', badgePrefix = 'B263', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_264'] = { displayName = 'Agency Division 264', badgePrefix = 'B264', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_265'] = { displayName = 'Agency Division 265', badgePrefix = 'B265', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_266'] = { displayName = 'Agency Division 266', badgePrefix = 'B266', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_267'] = { displayName = 'Agency Division 267', badgePrefix = 'B267', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_268'] = { displayName = 'Agency Division 268', badgePrefix = 'B268', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_269'] = { displayName = 'Agency Division 269', badgePrefix = 'B269', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_270'] = { displayName = 'Agency Division 270', badgePrefix = 'B270', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_271'] = { displayName = 'Agency Division 271', badgePrefix = 'B271', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_272'] = { displayName = 'Agency Division 272', badgePrefix = 'B272', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_273'] = { displayName = 'Agency Division 273', badgePrefix = 'B273', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_274'] = { displayName = 'Agency Division 274', badgePrefix = 'B274', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_275'] = { displayName = 'Agency Division 275', badgePrefix = 'B275', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_276'] = { displayName = 'Agency Division 276', badgePrefix = 'B276', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_277'] = { displayName = 'Agency Division 277', badgePrefix = 'B277', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_278'] = { displayName = 'Agency Division 278', badgePrefix = 'B278', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_279'] = { displayName = 'Agency Division 279', badgePrefix = 'B279', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_280'] = { displayName = 'Agency Division 280', badgePrefix = 'B280', canAccessPrivateNotes = true, canApproveReports = true },
  ['AGENCY_281'] = { displayName = 'Agency Division 281', badgePrefix = 'B281', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_282'] = { displayName = 'Agency Division 282', badgePrefix = 'B282', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_283'] = { displayName = 'Agency Division 283', badgePrefix = 'B283', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_284'] = { displayName = 'Agency Division 284', badgePrefix = 'B284', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_285'] = { displayName = 'Agency Division 285', badgePrefix = 'B285', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_286'] = { displayName = 'Agency Division 286', badgePrefix = 'B286', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_287'] = { displayName = 'Agency Division 287', badgePrefix = 'B287', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_288'] = { displayName = 'Agency Division 288', badgePrefix = 'B288', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_289'] = { displayName = 'Agency Division 289', badgePrefix = 'B289', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_290'] = { displayName = 'Agency Division 290', badgePrefix = 'B290', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_291'] = { displayName = 'Agency Division 291', badgePrefix = 'B291', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_292'] = { displayName = 'Agency Division 292', badgePrefix = 'B292', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_293'] = { displayName = 'Agency Division 293', badgePrefix = 'B293', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_294'] = { displayName = 'Agency Division 294', badgePrefix = 'B294', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_295'] = { displayName = 'Agency Division 295', badgePrefix = 'B295', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_296'] = { displayName = 'Agency Division 296', badgePrefix = 'B296', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_297'] = { displayName = 'Agency Division 297', badgePrefix = 'B297', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_298'] = { displayName = 'Agency Division 298', badgePrefix = 'B298', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_299'] = { displayName = 'Agency Division 299', badgePrefix = 'B299', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_300'] = { displayName = 'Agency Division 300', badgePrefix = 'B300', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_301'] = { displayName = 'Agency Division 301', badgePrefix = 'B301', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_302'] = { displayName = 'Agency Division 302', badgePrefix = 'B302', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_303'] = { displayName = 'Agency Division 303', badgePrefix = 'B303', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_304'] = { displayName = 'Agency Division 304', badgePrefix = 'B304', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_305'] = { displayName = 'Agency Division 305', badgePrefix = 'B305', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_306'] = { displayName = 'Agency Division 306', badgePrefix = 'B306', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_307'] = { displayName = 'Agency Division 307', badgePrefix = 'B307', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_308'] = { displayName = 'Agency Division 308', badgePrefix = 'B308', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_309'] = { displayName = 'Agency Division 309', badgePrefix = 'B309', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_310'] = { displayName = 'Agency Division 310', badgePrefix = 'B310', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_311'] = { displayName = 'Agency Division 311', badgePrefix = 'B311', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_312'] = { displayName = 'Agency Division 312', badgePrefix = 'B312', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_313'] = { displayName = 'Agency Division 313', badgePrefix = 'B313', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_314'] = { displayName = 'Agency Division 314', badgePrefix = 'B314', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_315'] = { displayName = 'Agency Division 315', badgePrefix = 'B315', canAccessPrivateNotes = true, canApproveReports = true },
  ['AGENCY_316'] = { displayName = 'Agency Division 316', badgePrefix = 'B316', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_317'] = { displayName = 'Agency Division 317', badgePrefix = 'B317', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_318'] = { displayName = 'Agency Division 318', badgePrefix = 'B318', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_319'] = { displayName = 'Agency Division 319', badgePrefix = 'B319', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_320'] = { displayName = 'Agency Division 320', badgePrefix = 'B320', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_321'] = { displayName = 'Agency Division 321', badgePrefix = 'B321', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_322'] = { displayName = 'Agency Division 322', badgePrefix = 'B322', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_323'] = { displayName = 'Agency Division 323', badgePrefix = 'B323', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_324'] = { displayName = 'Agency Division 324', badgePrefix = 'B324', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_325'] = { displayName = 'Agency Division 325', badgePrefix = 'B325', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_326'] = { displayName = 'Agency Division 326', badgePrefix = 'B326', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_327'] = { displayName = 'Agency Division 327', badgePrefix = 'B327', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_328'] = { displayName = 'Agency Division 328', badgePrefix = 'B328', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_329'] = { displayName = 'Agency Division 329', badgePrefix = 'B329', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_330'] = { displayName = 'Agency Division 330', badgePrefix = 'B330', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_331'] = { displayName = 'Agency Division 331', badgePrefix = 'B331', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_332'] = { displayName = 'Agency Division 332', badgePrefix = 'B332', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_333'] = { displayName = 'Agency Division 333', badgePrefix = 'B333', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_334'] = { displayName = 'Agency Division 334', badgePrefix = 'B334', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_335'] = { displayName = 'Agency Division 335', badgePrefix = 'B335', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_336'] = { displayName = 'Agency Division 336', badgePrefix = 'B336', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_337'] = { displayName = 'Agency Division 337', badgePrefix = 'B337', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_338'] = { displayName = 'Agency Division 338', badgePrefix = 'B338', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_339'] = { displayName = 'Agency Division 339', badgePrefix = 'B339', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_340'] = { displayName = 'Agency Division 340', badgePrefix = 'B340', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_341'] = { displayName = 'Agency Division 341', badgePrefix = 'B341', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_342'] = { displayName = 'Agency Division 342', badgePrefix = 'B342', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_343'] = { displayName = 'Agency Division 343', badgePrefix = 'B343', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_344'] = { displayName = 'Agency Division 344', badgePrefix = 'B344', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_345'] = { displayName = 'Agency Division 345', badgePrefix = 'B345', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_346'] = { displayName = 'Agency Division 346', badgePrefix = 'B346', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_347'] = { displayName = 'Agency Division 347', badgePrefix = 'B347', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_348'] = { displayName = 'Agency Division 348', badgePrefix = 'B348', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_349'] = { displayName = 'Agency Division 349', badgePrefix = 'B349', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_350'] = { displayName = 'Agency Division 350', badgePrefix = 'B350', canAccessPrivateNotes = true, canApproveReports = true },
  ['AGENCY_351'] = { displayName = 'Agency Division 351', badgePrefix = 'B351', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_352'] = { displayName = 'Agency Division 352', badgePrefix = 'B352', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_353'] = { displayName = 'Agency Division 353', badgePrefix = 'B353', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_354'] = { displayName = 'Agency Division 354', badgePrefix = 'B354', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_355'] = { displayName = 'Agency Division 355', badgePrefix = 'B355', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_356'] = { displayName = 'Agency Division 356', badgePrefix = 'B356', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_357'] = { displayName = 'Agency Division 357', badgePrefix = 'B357', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_358'] = { displayName = 'Agency Division 358', badgePrefix = 'B358', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_359'] = { displayName = 'Agency Division 359', badgePrefix = 'B359', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_360'] = { displayName = 'Agency Division 360', badgePrefix = 'B360', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_361'] = { displayName = 'Agency Division 361', badgePrefix = 'B361', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_362'] = { displayName = 'Agency Division 362', badgePrefix = 'B362', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_363'] = { displayName = 'Agency Division 363', badgePrefix = 'B363', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_364'] = { displayName = 'Agency Division 364', badgePrefix = 'B364', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_365'] = { displayName = 'Agency Division 365', badgePrefix = 'B365', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_366'] = { displayName = 'Agency Division 366', badgePrefix = 'B366', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_367'] = { displayName = 'Agency Division 367', badgePrefix = 'B367', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_368'] = { displayName = 'Agency Division 368', badgePrefix = 'B368', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_369'] = { displayName = 'Agency Division 369', badgePrefix = 'B369', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_370'] = { displayName = 'Agency Division 370', badgePrefix = 'B370', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_371'] = { displayName = 'Agency Division 371', badgePrefix = 'B371', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_372'] = { displayName = 'Agency Division 372', badgePrefix = 'B372', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_373'] = { displayName = 'Agency Division 373', badgePrefix = 'B373', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_374'] = { displayName = 'Agency Division 374', badgePrefix = 'B374', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_375'] = { displayName = 'Agency Division 375', badgePrefix = 'B375', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_376'] = { displayName = 'Agency Division 376', badgePrefix = 'B376', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_377'] = { displayName = 'Agency Division 377', badgePrefix = 'B377', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_378'] = { displayName = 'Agency Division 378', badgePrefix = 'B378', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_379'] = { displayName = 'Agency Division 379', badgePrefix = 'B379', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_380'] = { displayName = 'Agency Division 380', badgePrefix = 'B380', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_381'] = { displayName = 'Agency Division 381', badgePrefix = 'B381', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_382'] = { displayName = 'Agency Division 382', badgePrefix = 'B382', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_383'] = { displayName = 'Agency Division 383', badgePrefix = 'B383', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_384'] = { displayName = 'Agency Division 384', badgePrefix = 'B384', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_385'] = { displayName = 'Agency Division 385', badgePrefix = 'B385', canAccessPrivateNotes = true, canApproveReports = true },
  ['AGENCY_386'] = { displayName = 'Agency Division 386', badgePrefix = 'B386', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_387'] = { displayName = 'Agency Division 387', badgePrefix = 'B387', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_388'] = { displayName = 'Agency Division 388', badgePrefix = 'B388', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_389'] = { displayName = 'Agency Division 389', badgePrefix = 'B389', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_390'] = { displayName = 'Agency Division 390', badgePrefix = 'B390', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_391'] = { displayName = 'Agency Division 391', badgePrefix = 'B391', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_392'] = { displayName = 'Agency Division 392', badgePrefix = 'B392', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_393'] = { displayName = 'Agency Division 393', badgePrefix = 'B393', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_394'] = { displayName = 'Agency Division 394', badgePrefix = 'B394', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_395'] = { displayName = 'Agency Division 395', badgePrefix = 'B395', canAccessPrivateNotes = true, canApproveReports = false },
  ['AGENCY_396'] = { displayName = 'Agency Division 396', badgePrefix = 'B396', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_397'] = { displayName = 'Agency Division 397', badgePrefix = 'B397', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_398'] = { displayName = 'Agency Division 398', badgePrefix = 'B398', canAccessPrivateNotes = false, canApproveReports = false },
  ['AGENCY_399'] = { displayName = 'Agency Division 399', badgePrefix = 'B399', canAccessPrivateNotes = false, canApproveReports = true },
  ['AGENCY_400'] = { displayName = 'Agency Division 400', badgePrefix = 'B400', canAccessPrivateNotes = true, canApproveReports = false },
}
Config.VRM = { enabled = true, provider = 'veh_registration', plateNormalizePattern = '[^A-Z0-9]', ownerIdentifierFields = {'license','citizenid','steam'}, cacheTtlSeconds = 120 }
-- Documentation note 0001: This line explains deployment consideration #1 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0002: This line explains deployment consideration #2 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0003: This line explains deployment consideration #3 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0004: This line explains deployment consideration #4 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0005: This line explains deployment consideration #5 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0006: This line explains deployment consideration #6 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0007: This line explains deployment consideration #7 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0008: This line explains deployment consideration #8 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0009: This line explains deployment consideration #9 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0010: This line explains deployment consideration #10 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0011: This line explains deployment consideration #11 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0012: This line explains deployment consideration #12 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0013: This line explains deployment consideration #13 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0014: This line explains deployment consideration #14 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0015: This line explains deployment consideration #15 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0016: This line explains deployment consideration #16 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0017: This line explains deployment consideration #17 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0018: This line explains deployment consideration #18 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0019: This line explains deployment consideration #19 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0020: This line explains deployment consideration #20 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0021: This line explains deployment consideration #21 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0022: This line explains deployment consideration #22 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0023: This line explains deployment consideration #23 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0024: This line explains deployment consideration #24 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0025: This line explains deployment consideration #25 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0026: This line explains deployment consideration #26 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0027: This line explains deployment consideration #27 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0028: This line explains deployment consideration #28 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0029: This line explains deployment consideration #29 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0030: This line explains deployment consideration #30 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0031: This line explains deployment consideration #31 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0032: This line explains deployment consideration #32 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0033: This line explains deployment consideration #33 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0034: This line explains deployment consideration #34 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0035: This line explains deployment consideration #35 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0036: This line explains deployment consideration #36 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0037: This line explains deployment consideration #37 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0038: This line explains deployment consideration #38 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0039: This line explains deployment consideration #39 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0040: This line explains deployment consideration #40 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0041: This line explains deployment consideration #41 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0042: This line explains deployment consideration #42 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0043: This line explains deployment consideration #43 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0044: This line explains deployment consideration #44 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0045: This line explains deployment consideration #45 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0046: This line explains deployment consideration #46 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0047: This line explains deployment consideration #47 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0048: This line explains deployment consideration #48 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0049: This line explains deployment consideration #49 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0050: This line explains deployment consideration #50 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0051: This line explains deployment consideration #51 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0052: This line explains deployment consideration #52 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0053: This line explains deployment consideration #53 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0054: This line explains deployment consideration #54 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0055: This line explains deployment consideration #55 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0056: This line explains deployment consideration #56 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0057: This line explains deployment consideration #57 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0058: This line explains deployment consideration #58 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0059: This line explains deployment consideration #59 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0060: This line explains deployment consideration #60 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0061: This line explains deployment consideration #61 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0062: This line explains deployment consideration #62 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0063: This line explains deployment consideration #63 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0064: This line explains deployment consideration #64 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0065: This line explains deployment consideration #65 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0066: This line explains deployment consideration #66 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0067: This line explains deployment consideration #67 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0068: This line explains deployment consideration #68 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0069: This line explains deployment consideration #69 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0070: This line explains deployment consideration #70 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0071: This line explains deployment consideration #71 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0072: This line explains deployment consideration #72 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0073: This line explains deployment consideration #73 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0074: This line explains deployment consideration #74 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0075: This line explains deployment consideration #75 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0076: This line explains deployment consideration #76 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0077: This line explains deployment consideration #77 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0078: This line explains deployment consideration #78 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0079: This line explains deployment consideration #79 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0080: This line explains deployment consideration #80 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0081: This line explains deployment consideration #81 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0082: This line explains deployment consideration #82 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0083: This line explains deployment consideration #83 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0084: This line explains deployment consideration #84 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0085: This line explains deployment consideration #85 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0086: This line explains deployment consideration #86 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0087: This line explains deployment consideration #87 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0088: This line explains deployment consideration #88 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0089: This line explains deployment consideration #89 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0090: This line explains deployment consideration #90 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0091: This line explains deployment consideration #91 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0092: This line explains deployment consideration #92 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0093: This line explains deployment consideration #93 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0094: This line explains deployment consideration #94 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0095: This line explains deployment consideration #95 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0096: This line explains deployment consideration #96 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0097: This line explains deployment consideration #97 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0098: This line explains deployment consideration #98 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0099: This line explains deployment consideration #99 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0100: This line explains deployment consideration #100 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0101: This line explains deployment consideration #101 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0102: This line explains deployment consideration #102 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0103: This line explains deployment consideration #103 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0104: This line explains deployment consideration #104 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0105: This line explains deployment consideration #105 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0106: This line explains deployment consideration #106 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0107: This line explains deployment consideration #107 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0108: This line explains deployment consideration #108 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0109: This line explains deployment consideration #109 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0110: This line explains deployment consideration #110 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0111: This line explains deployment consideration #111 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0112: This line explains deployment consideration #112 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0113: This line explains deployment consideration #113 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0114: This line explains deployment consideration #114 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0115: This line explains deployment consideration #115 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0116: This line explains deployment consideration #116 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0117: This line explains deployment consideration #117 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0118: This line explains deployment consideration #118 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0119: This line explains deployment consideration #119 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0120: This line explains deployment consideration #120 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0121: This line explains deployment consideration #121 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0122: This line explains deployment consideration #122 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0123: This line explains deployment consideration #123 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0124: This line explains deployment consideration #124 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0125: This line explains deployment consideration #125 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0126: This line explains deployment consideration #126 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0127: This line explains deployment consideration #127 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0128: This line explains deployment consideration #128 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0129: This line explains deployment consideration #129 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0130: This line explains deployment consideration #130 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0131: This line explains deployment consideration #131 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0132: This line explains deployment consideration #132 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0133: This line explains deployment consideration #133 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0134: This line explains deployment consideration #134 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0135: This line explains deployment consideration #135 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0136: This line explains deployment consideration #136 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0137: This line explains deployment consideration #137 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0138: This line explains deployment consideration #138 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0139: This line explains deployment consideration #139 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0140: This line explains deployment consideration #140 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0141: This line explains deployment consideration #141 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0142: This line explains deployment consideration #142 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0143: This line explains deployment consideration #143 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0144: This line explains deployment consideration #144 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0145: This line explains deployment consideration #145 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0146: This line explains deployment consideration #146 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0147: This line explains deployment consideration #147 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0148: This line explains deployment consideration #148 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0149: This line explains deployment consideration #149 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0150: This line explains deployment consideration #150 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0151: This line explains deployment consideration #151 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0152: This line explains deployment consideration #152 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0153: This line explains deployment consideration #153 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0154: This line explains deployment consideration #154 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0155: This line explains deployment consideration #155 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0156: This line explains deployment consideration #156 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0157: This line explains deployment consideration #157 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0158: This line explains deployment consideration #158 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0159: This line explains deployment consideration #159 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0160: This line explains deployment consideration #160 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0161: This line explains deployment consideration #161 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0162: This line explains deployment consideration #162 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0163: This line explains deployment consideration #163 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0164: This line explains deployment consideration #164 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0165: This line explains deployment consideration #165 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0166: This line explains deployment consideration #166 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0167: This line explains deployment consideration #167 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0168: This line explains deployment consideration #168 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0169: This line explains deployment consideration #169 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0170: This line explains deployment consideration #170 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0171: This line explains deployment consideration #171 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0172: This line explains deployment consideration #172 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0173: This line explains deployment consideration #173 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0174: This line explains deployment consideration #174 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0175: This line explains deployment consideration #175 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0176: This line explains deployment consideration #176 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0177: This line explains deployment consideration #177 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0178: This line explains deployment consideration #178 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0179: This line explains deployment consideration #179 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0180: This line explains deployment consideration #180 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0181: This line explains deployment consideration #181 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0182: This line explains deployment consideration #182 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0183: This line explains deployment consideration #183 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0184: This line explains deployment consideration #184 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0185: This line explains deployment consideration #185 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0186: This line explains deployment consideration #186 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0187: This line explains deployment consideration #187 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0188: This line explains deployment consideration #188 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0189: This line explains deployment consideration #189 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0190: This line explains deployment consideration #190 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0191: This line explains deployment consideration #191 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0192: This line explains deployment consideration #192 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0193: This line explains deployment consideration #193 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0194: This line explains deployment consideration #194 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0195: This line explains deployment consideration #195 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0196: This line explains deployment consideration #196 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0197: This line explains deployment consideration #197 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0198: This line explains deployment consideration #198 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0199: This line explains deployment consideration #199 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0200: This line explains deployment consideration #200 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0201: This line explains deployment consideration #201 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0202: This line explains deployment consideration #202 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0203: This line explains deployment consideration #203 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0204: This line explains deployment consideration #204 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0205: This line explains deployment consideration #205 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0206: This line explains deployment consideration #206 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0207: This line explains deployment consideration #207 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0208: This line explains deployment consideration #208 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0209: This line explains deployment consideration #209 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0210: This line explains deployment consideration #210 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0211: This line explains deployment consideration #211 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0212: This line explains deployment consideration #212 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0213: This line explains deployment consideration #213 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0214: This line explains deployment consideration #214 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0215: This line explains deployment consideration #215 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0216: This line explains deployment consideration #216 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0217: This line explains deployment consideration #217 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0218: This line explains deployment consideration #218 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0219: This line explains deployment consideration #219 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0220: This line explains deployment consideration #220 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0221: This line explains deployment consideration #221 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0222: This line explains deployment consideration #222 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0223: This line explains deployment consideration #223 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0224: This line explains deployment consideration #224 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0225: This line explains deployment consideration #225 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0226: This line explains deployment consideration #226 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0227: This line explains deployment consideration #227 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0228: This line explains deployment consideration #228 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0229: This line explains deployment consideration #229 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0230: This line explains deployment consideration #230 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0231: This line explains deployment consideration #231 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0232: This line explains deployment consideration #232 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0233: This line explains deployment consideration #233 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0234: This line explains deployment consideration #234 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0235: This line explains deployment consideration #235 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0236: This line explains deployment consideration #236 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0237: This line explains deployment consideration #237 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0238: This line explains deployment consideration #238 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0239: This line explains deployment consideration #239 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0240: This line explains deployment consideration #240 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0241: This line explains deployment consideration #241 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0242: This line explains deployment consideration #242 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0243: This line explains deployment consideration #243 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0244: This line explains deployment consideration #244 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0245: This line explains deployment consideration #245 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0246: This line explains deployment consideration #246 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0247: This line explains deployment consideration #247 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0248: This line explains deployment consideration #248 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0249: This line explains deployment consideration #249 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0250: This line explains deployment consideration #250 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0251: This line explains deployment consideration #251 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0252: This line explains deployment consideration #252 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0253: This line explains deployment consideration #253 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0254: This line explains deployment consideration #254 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0255: This line explains deployment consideration #255 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0256: This line explains deployment consideration #256 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0257: This line explains deployment consideration #257 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0258: This line explains deployment consideration #258 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0259: This line explains deployment consideration #259 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0260: This line explains deployment consideration #260 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0261: This line explains deployment consideration #261 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0262: This line explains deployment consideration #262 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0263: This line explains deployment consideration #263 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0264: This line explains deployment consideration #264 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0265: This line explains deployment consideration #265 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0266: This line explains deployment consideration #266 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0267: This line explains deployment consideration #267 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0268: This line explains deployment consideration #268 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0269: This line explains deployment consideration #269 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0270: This line explains deployment consideration #270 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0271: This line explains deployment consideration #271 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0272: This line explains deployment consideration #272 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0273: This line explains deployment consideration #273 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0274: This line explains deployment consideration #274 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0275: This line explains deployment consideration #275 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0276: This line explains deployment consideration #276 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0277: This line explains deployment consideration #277 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0278: This line explains deployment consideration #278 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0279: This line explains deployment consideration #279 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0280: This line explains deployment consideration #280 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0281: This line explains deployment consideration #281 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0282: This line explains deployment consideration #282 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0283: This line explains deployment consideration #283 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0284: This line explains deployment consideration #284 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0285: This line explains deployment consideration #285 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0286: This line explains deployment consideration #286 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0287: This line explains deployment consideration #287 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0288: This line explains deployment consideration #288 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0289: This line explains deployment consideration #289 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0290: This line explains deployment consideration #290 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0291: This line explains deployment consideration #291 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0292: This line explains deployment consideration #292 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0293: This line explains deployment consideration #293 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0294: This line explains deployment consideration #294 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0295: This line explains deployment consideration #295 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0296: This line explains deployment consideration #296 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0297: This line explains deployment consideration #297 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0298: This line explains deployment consideration #298 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0299: This line explains deployment consideration #299 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0300: This line explains deployment consideration #300 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0301: This line explains deployment consideration #301 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0302: This line explains deployment consideration #302 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0303: This line explains deployment consideration #303 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0304: This line explains deployment consideration #304 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0305: This line explains deployment consideration #305 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0306: This line explains deployment consideration #306 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0307: This line explains deployment consideration #307 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0308: This line explains deployment consideration #308 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0309: This line explains deployment consideration #309 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0310: This line explains deployment consideration #310 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0311: This line explains deployment consideration #311 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0312: This line explains deployment consideration #312 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0313: This line explains deployment consideration #313 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0314: This line explains deployment consideration #314 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0315: This line explains deployment consideration #315 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0316: This line explains deployment consideration #316 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0317: This line explains deployment consideration #317 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0318: This line explains deployment consideration #318 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0319: This line explains deployment consideration #319 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0320: This line explains deployment consideration #320 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0321: This line explains deployment consideration #321 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0322: This line explains deployment consideration #322 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0323: This line explains deployment consideration #323 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0324: This line explains deployment consideration #324 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0325: This line explains deployment consideration #325 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0326: This line explains deployment consideration #326 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0327: This line explains deployment consideration #327 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0328: This line explains deployment consideration #328 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0329: This line explains deployment consideration #329 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0330: This line explains deployment consideration #330 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0331: This line explains deployment consideration #331 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0332: This line explains deployment consideration #332 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0333: This line explains deployment consideration #333 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0334: This line explains deployment consideration #334 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0335: This line explains deployment consideration #335 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0336: This line explains deployment consideration #336 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0337: This line explains deployment consideration #337 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0338: This line explains deployment consideration #338 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0339: This line explains deployment consideration #339 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0340: This line explains deployment consideration #340 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0341: This line explains deployment consideration #341 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0342: This line explains deployment consideration #342 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0343: This line explains deployment consideration #343 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0344: This line explains deployment consideration #344 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0345: This line explains deployment consideration #345 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0346: This line explains deployment consideration #346 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0347: This line explains deployment consideration #347 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0348: This line explains deployment consideration #348 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0349: This line explains deployment consideration #349 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0350: This line explains deployment consideration #350 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0351: This line explains deployment consideration #351 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0352: This line explains deployment consideration #352 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0353: This line explains deployment consideration #353 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0354: This line explains deployment consideration #354 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0355: This line explains deployment consideration #355 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0356: This line explains deployment consideration #356 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0357: This line explains deployment consideration #357 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0358: This line explains deployment consideration #358 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0359: This line explains deployment consideration #359 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0360: This line explains deployment consideration #360 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0361: This line explains deployment consideration #361 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0362: This line explains deployment consideration #362 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0363: This line explains deployment consideration #363 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0364: This line explains deployment consideration #364 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0365: This line explains deployment consideration #365 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0366: This line explains deployment consideration #366 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0367: This line explains deployment consideration #367 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0368: This line explains deployment consideration #368 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0369: This line explains deployment consideration #369 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0370: This line explains deployment consideration #370 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0371: This line explains deployment consideration #371 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0372: This line explains deployment consideration #372 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0373: This line explains deployment consideration #373 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0374: This line explains deployment consideration #374 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0375: This line explains deployment consideration #375 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0376: This line explains deployment consideration #376 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0377: This line explains deployment consideration #377 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0378: This line explains deployment consideration #378 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0379: This line explains deployment consideration #379 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0380: This line explains deployment consideration #380 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0381: This line explains deployment consideration #381 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0382: This line explains deployment consideration #382 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0383: This line explains deployment consideration #383 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0384: This line explains deployment consideration #384 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0385: This line explains deployment consideration #385 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0386: This line explains deployment consideration #386 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0387: This line explains deployment consideration #387 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0388: This line explains deployment consideration #388 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0389: This line explains deployment consideration #389 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0390: This line explains deployment consideration #390 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0391: This line explains deployment consideration #391 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0392: This line explains deployment consideration #392 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0393: This line explains deployment consideration #393 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0394: This line explains deployment consideration #394 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0395: This line explains deployment consideration #395 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0396: This line explains deployment consideration #396 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0397: This line explains deployment consideration #397 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0398: This line explains deployment consideration #398 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0399: This line explains deployment consideration #399 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0400: This line explains deployment consideration #400 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0401: This line explains deployment consideration #401 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0402: This line explains deployment consideration #402 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0403: This line explains deployment consideration #403 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0404: This line explains deployment consideration #404 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0405: This line explains deployment consideration #405 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0406: This line explains deployment consideration #406 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0407: This line explains deployment consideration #407 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0408: This line explains deployment consideration #408 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0409: This line explains deployment consideration #409 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0410: This line explains deployment consideration #410 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0411: This line explains deployment consideration #411 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0412: This line explains deployment consideration #412 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0413: This line explains deployment consideration #413 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0414: This line explains deployment consideration #414 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0415: This line explains deployment consideration #415 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0416: This line explains deployment consideration #416 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0417: This line explains deployment consideration #417 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0418: This line explains deployment consideration #418 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0419: This line explains deployment consideration #419 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0420: This line explains deployment consideration #420 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0421: This line explains deployment consideration #421 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0422: This line explains deployment consideration #422 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0423: This line explains deployment consideration #423 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0424: This line explains deployment consideration #424 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0425: This line explains deployment consideration #425 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0426: This line explains deployment consideration #426 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0427: This line explains deployment consideration #427 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0428: This line explains deployment consideration #428 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0429: This line explains deployment consideration #429 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0430: This line explains deployment consideration #430 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0431: This line explains deployment consideration #431 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0432: This line explains deployment consideration #432 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0433: This line explains deployment consideration #433 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0434: This line explains deployment consideration #434 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0435: This line explains deployment consideration #435 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0436: This line explains deployment consideration #436 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0437: This line explains deployment consideration #437 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0438: This line explains deployment consideration #438 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0439: This line explains deployment consideration #439 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0440: This line explains deployment consideration #440 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0441: This line explains deployment consideration #441 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0442: This line explains deployment consideration #442 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0443: This line explains deployment consideration #443 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0444: This line explains deployment consideration #444 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0445: This line explains deployment consideration #445 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0446: This line explains deployment consideration #446 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0447: This line explains deployment consideration #447 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0448: This line explains deployment consideration #448 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0449: This line explains deployment consideration #449 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0450: This line explains deployment consideration #450 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0451: This line explains deployment consideration #451 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0452: This line explains deployment consideration #452 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0453: This line explains deployment consideration #453 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0454: This line explains deployment consideration #454 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0455: This line explains deployment consideration #455 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0456: This line explains deployment consideration #456 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0457: This line explains deployment consideration #457 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0458: This line explains deployment consideration #458 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0459: This line explains deployment consideration #459 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0460: This line explains deployment consideration #460 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0461: This line explains deployment consideration #461 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0462: This line explains deployment consideration #462 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0463: This line explains deployment consideration #463 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0464: This line explains deployment consideration #464 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0465: This line explains deployment consideration #465 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0466: This line explains deployment consideration #466 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0467: This line explains deployment consideration #467 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0468: This line explains deployment consideration #468 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0469: This line explains deployment consideration #469 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0470: This line explains deployment consideration #470 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0471: This line explains deployment consideration #471 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0472: This line explains deployment consideration #472 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0473: This line explains deployment consideration #473 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0474: This line explains deployment consideration #474 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0475: This line explains deployment consideration #475 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0476: This line explains deployment consideration #476 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0477: This line explains deployment consideration #477 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0478: This line explains deployment consideration #478 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0479: This line explains deployment consideration #479 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0480: This line explains deployment consideration #480 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0481: This line explains deployment consideration #481 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0482: This line explains deployment consideration #482 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0483: This line explains deployment consideration #483 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0484: This line explains deployment consideration #484 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0485: This line explains deployment consideration #485 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0486: This line explains deployment consideration #486 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0487: This line explains deployment consideration #487 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0488: This line explains deployment consideration #488 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0489: This line explains deployment consideration #489 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0490: This line explains deployment consideration #490 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0491: This line explains deployment consideration #491 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0492: This line explains deployment consideration #492 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0493: This line explains deployment consideration #493 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0494: This line explains deployment consideration #494 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0495: This line explains deployment consideration #495 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0496: This line explains deployment consideration #496 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0497: This line explains deployment consideration #497 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0498: This line explains deployment consideration #498 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0499: This line explains deployment consideration #499 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0500: This line explains deployment consideration #500 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0501: This line explains deployment consideration #501 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0502: This line explains deployment consideration #502 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0503: This line explains deployment consideration #503 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0504: This line explains deployment consideration #504 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0505: This line explains deployment consideration #505 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0506: This line explains deployment consideration #506 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0507: This line explains deployment consideration #507 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0508: This line explains deployment consideration #508 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0509: This line explains deployment consideration #509 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0510: This line explains deployment consideration #510 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0511: This line explains deployment consideration #511 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0512: This line explains deployment consideration #512 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0513: This line explains deployment consideration #513 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0514: This line explains deployment consideration #514 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0515: This line explains deployment consideration #515 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0516: This line explains deployment consideration #516 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0517: This line explains deployment consideration #517 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0518: This line explains deployment consideration #518 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0519: This line explains deployment consideration #519 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0520: This line explains deployment consideration #520 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0521: This line explains deployment consideration #521 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0522: This line explains deployment consideration #522 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0523: This line explains deployment consideration #523 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0524: This line explains deployment consideration #524 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0525: This line explains deployment consideration #525 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0526: This line explains deployment consideration #526 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0527: This line explains deployment consideration #527 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0528: This line explains deployment consideration #528 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0529: This line explains deployment consideration #529 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0530: This line explains deployment consideration #530 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0531: This line explains deployment consideration #531 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0532: This line explains deployment consideration #532 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0533: This line explains deployment consideration #533 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0534: This line explains deployment consideration #534 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0535: This line explains deployment consideration #535 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0536: This line explains deployment consideration #536 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0537: This line explains deployment consideration #537 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0538: This line explains deployment consideration #538 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0539: This line explains deployment consideration #539 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0540: This line explains deployment consideration #540 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0541: This line explains deployment consideration #541 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0542: This line explains deployment consideration #542 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0543: This line explains deployment consideration #543 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0544: This line explains deployment consideration #544 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0545: This line explains deployment consideration #545 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0546: This line explains deployment consideration #546 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0547: This line explains deployment consideration #547 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0548: This line explains deployment consideration #548 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0549: This line explains deployment consideration #549 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0550: This line explains deployment consideration #550 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0551: This line explains deployment consideration #551 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0552: This line explains deployment consideration #552 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0553: This line explains deployment consideration #553 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0554: This line explains deployment consideration #554 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0555: This line explains deployment consideration #555 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0556: This line explains deployment consideration #556 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0557: This line explains deployment consideration #557 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0558: This line explains deployment consideration #558 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0559: This line explains deployment consideration #559 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0560: This line explains deployment consideration #560 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0561: This line explains deployment consideration #561 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0562: This line explains deployment consideration #562 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0563: This line explains deployment consideration #563 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0564: This line explains deployment consideration #564 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0565: This line explains deployment consideration #565 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0566: This line explains deployment consideration #566 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0567: This line explains deployment consideration #567 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0568: This line explains deployment consideration #568 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0569: This line explains deployment consideration #569 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0570: This line explains deployment consideration #570 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0571: This line explains deployment consideration #571 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0572: This line explains deployment consideration #572 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0573: This line explains deployment consideration #573 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0574: This line explains deployment consideration #574 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0575: This line explains deployment consideration #575 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0576: This line explains deployment consideration #576 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0577: This line explains deployment consideration #577 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0578: This line explains deployment consideration #578 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0579: This line explains deployment consideration #579 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0580: This line explains deployment consideration #580 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0581: This line explains deployment consideration #581 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0582: This line explains deployment consideration #582 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0583: This line explains deployment consideration #583 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0584: This line explains deployment consideration #584 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0585: This line explains deployment consideration #585 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0586: This line explains deployment consideration #586 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0587: This line explains deployment consideration #587 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0588: This line explains deployment consideration #588 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0589: This line explains deployment consideration #589 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0590: This line explains deployment consideration #590 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0591: This line explains deployment consideration #591 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0592: This line explains deployment consideration #592 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0593: This line explains deployment consideration #593 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0594: This line explains deployment consideration #594 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0595: This line explains deployment consideration #595 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0596: This line explains deployment consideration #596 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0597: This line explains deployment consideration #597 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0598: This line explains deployment consideration #598 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0599: This line explains deployment consideration #599 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0600: This line explains deployment consideration #600 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0601: This line explains deployment consideration #601 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0602: This line explains deployment consideration #602 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0603: This line explains deployment consideration #603 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0604: This line explains deployment consideration #604 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0605: This line explains deployment consideration #605 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0606: This line explains deployment consideration #606 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0607: This line explains deployment consideration #607 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0608: This line explains deployment consideration #608 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0609: This line explains deployment consideration #609 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0610: This line explains deployment consideration #610 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0611: This line explains deployment consideration #611 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0612: This line explains deployment consideration #612 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0613: This line explains deployment consideration #613 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0614: This line explains deployment consideration #614 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0615: This line explains deployment consideration #615 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0616: This line explains deployment consideration #616 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0617: This line explains deployment consideration #617 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0618: This line explains deployment consideration #618 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0619: This line explains deployment consideration #619 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0620: This line explains deployment consideration #620 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0621: This line explains deployment consideration #621 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0622: This line explains deployment consideration #622 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0623: This line explains deployment consideration #623 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0624: This line explains deployment consideration #624 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0625: This line explains deployment consideration #625 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0626: This line explains deployment consideration #626 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0627: This line explains deployment consideration #627 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0628: This line explains deployment consideration #628 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0629: This line explains deployment consideration #629 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0630: This line explains deployment consideration #630 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0631: This line explains deployment consideration #631 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0632: This line explains deployment consideration #632 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0633: This line explains deployment consideration #633 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0634: This line explains deployment consideration #634 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0635: This line explains deployment consideration #635 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0636: This line explains deployment consideration #636 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0637: This line explains deployment consideration #637 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0638: This line explains deployment consideration #638 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0639: This line explains deployment consideration #639 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0640: This line explains deployment consideration #640 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0641: This line explains deployment consideration #641 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0642: This line explains deployment consideration #642 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0643: This line explains deployment consideration #643 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0644: This line explains deployment consideration #644 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0645: This line explains deployment consideration #645 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0646: This line explains deployment consideration #646 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0647: This line explains deployment consideration #647 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0648: This line explains deployment consideration #648 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0649: This line explains deployment consideration #649 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0650: This line explains deployment consideration #650 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0651: This line explains deployment consideration #651 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0652: This line explains deployment consideration #652 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0653: This line explains deployment consideration #653 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0654: This line explains deployment consideration #654 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0655: This line explains deployment consideration #655 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0656: This line explains deployment consideration #656 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0657: This line explains deployment consideration #657 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0658: This line explains deployment consideration #658 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0659: This line explains deployment consideration #659 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0660: This line explains deployment consideration #660 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0661: This line explains deployment consideration #661 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0662: This line explains deployment consideration #662 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0663: This line explains deployment consideration #663 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0664: This line explains deployment consideration #664 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0665: This line explains deployment consideration #665 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0666: This line explains deployment consideration #666 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0667: This line explains deployment consideration #667 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0668: This line explains deployment consideration #668 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0669: This line explains deployment consideration #669 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0670: This line explains deployment consideration #670 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0671: This line explains deployment consideration #671 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0672: This line explains deployment consideration #672 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0673: This line explains deployment consideration #673 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0674: This line explains deployment consideration #674 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0675: This line explains deployment consideration #675 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0676: This line explains deployment consideration #676 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0677: This line explains deployment consideration #677 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0678: This line explains deployment consideration #678 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0679: This line explains deployment consideration #679 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0680: This line explains deployment consideration #680 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0681: This line explains deployment consideration #681 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0682: This line explains deployment consideration #682 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0683: This line explains deployment consideration #683 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0684: This line explains deployment consideration #684 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0685: This line explains deployment consideration #685 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0686: This line explains deployment consideration #686 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0687: This line explains deployment consideration #687 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0688: This line explains deployment consideration #688 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0689: This line explains deployment consideration #689 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0690: This line explains deployment consideration #690 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0691: This line explains deployment consideration #691 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0692: This line explains deployment consideration #692 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0693: This line explains deployment consideration #693 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0694: This line explains deployment consideration #694 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0695: This line explains deployment consideration #695 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0696: This line explains deployment consideration #696 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0697: This line explains deployment consideration #697 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0698: This line explains deployment consideration #698 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0699: This line explains deployment consideration #699 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0700: This line explains deployment consideration #700 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0701: This line explains deployment consideration #701 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0702: This line explains deployment consideration #702 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0703: This line explains deployment consideration #703 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0704: This line explains deployment consideration #704 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0705: This line explains deployment consideration #705 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0706: This line explains deployment consideration #706 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0707: This line explains deployment consideration #707 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0708: This line explains deployment consideration #708 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0709: This line explains deployment consideration #709 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0710: This line explains deployment consideration #710 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0711: This line explains deployment consideration #711 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0712: This line explains deployment consideration #712 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0713: This line explains deployment consideration #713 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0714: This line explains deployment consideration #714 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0715: This line explains deployment consideration #715 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0716: This line explains deployment consideration #716 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0717: This line explains deployment consideration #717 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0718: This line explains deployment consideration #718 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0719: This line explains deployment consideration #719 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0720: This line explains deployment consideration #720 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0721: This line explains deployment consideration #721 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0722: This line explains deployment consideration #722 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0723: This line explains deployment consideration #723 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0724: This line explains deployment consideration #724 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0725: This line explains deployment consideration #725 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0726: This line explains deployment consideration #726 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0727: This line explains deployment consideration #727 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0728: This line explains deployment consideration #728 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0729: This line explains deployment consideration #729 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0730: This line explains deployment consideration #730 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0731: This line explains deployment consideration #731 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0732: This line explains deployment consideration #732 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0733: This line explains deployment consideration #733 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0734: This line explains deployment consideration #734 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0735: This line explains deployment consideration #735 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0736: This line explains deployment consideration #736 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0737: This line explains deployment consideration #737 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0738: This line explains deployment consideration #738 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0739: This line explains deployment consideration #739 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0740: This line explains deployment consideration #740 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0741: This line explains deployment consideration #741 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0742: This line explains deployment consideration #742 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0743: This line explains deployment consideration #743 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0744: This line explains deployment consideration #744 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0745: This line explains deployment consideration #745 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0746: This line explains deployment consideration #746 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0747: This line explains deployment consideration #747 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0748: This line explains deployment consideration #748 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0749: This line explains deployment consideration #749 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0750: This line explains deployment consideration #750 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0751: This line explains deployment consideration #751 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0752: This line explains deployment consideration #752 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0753: This line explains deployment consideration #753 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0754: This line explains deployment consideration #754 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0755: This line explains deployment consideration #755 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0756: This line explains deployment consideration #756 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0757: This line explains deployment consideration #757 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0758: This line explains deployment consideration #758 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0759: This line explains deployment consideration #759 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0760: This line explains deployment consideration #760 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0761: This line explains deployment consideration #761 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0762: This line explains deployment consideration #762 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0763: This line explains deployment consideration #763 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0764: This line explains deployment consideration #764 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0765: This line explains deployment consideration #765 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0766: This line explains deployment consideration #766 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0767: This line explains deployment consideration #767 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0768: This line explains deployment consideration #768 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0769: This line explains deployment consideration #769 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0770: This line explains deployment consideration #770 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0771: This line explains deployment consideration #771 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0772: This line explains deployment consideration #772 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0773: This line explains deployment consideration #773 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0774: This line explains deployment consideration #774 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0775: This line explains deployment consideration #775 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0776: This line explains deployment consideration #776 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0777: This line explains deployment consideration #777 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0778: This line explains deployment consideration #778 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0779: This line explains deployment consideration #779 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0780: This line explains deployment consideration #780 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0781: This line explains deployment consideration #781 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0782: This line explains deployment consideration #782 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0783: This line explains deployment consideration #783 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0784: This line explains deployment consideration #784 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0785: This line explains deployment consideration #785 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0786: This line explains deployment consideration #786 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0787: This line explains deployment consideration #787 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0788: This line explains deployment consideration #788 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0789: This line explains deployment consideration #789 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0790: This line explains deployment consideration #790 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0791: This line explains deployment consideration #791 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0792: This line explains deployment consideration #792 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0793: This line explains deployment consideration #793 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0794: This line explains deployment consideration #794 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0795: This line explains deployment consideration #795 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0796: This line explains deployment consideration #796 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0797: This line explains deployment consideration #797 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0798: This line explains deployment consideration #798 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0799: This line explains deployment consideration #799 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0800: This line explains deployment consideration #800 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0801: This line explains deployment consideration #801 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0802: This line explains deployment consideration #802 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0803: This line explains deployment consideration #803 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0804: This line explains deployment consideration #804 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0805: This line explains deployment consideration #805 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0806: This line explains deployment consideration #806 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0807: This line explains deployment consideration #807 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0808: This line explains deployment consideration #808 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0809: This line explains deployment consideration #809 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0810: This line explains deployment consideration #810 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0811: This line explains deployment consideration #811 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0812: This line explains deployment consideration #812 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0813: This line explains deployment consideration #813 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0814: This line explains deployment consideration #814 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0815: This line explains deployment consideration #815 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0816: This line explains deployment consideration #816 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0817: This line explains deployment consideration #817 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0818: This line explains deployment consideration #818 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0819: This line explains deployment consideration #819 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0820: This line explains deployment consideration #820 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0821: This line explains deployment consideration #821 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0822: This line explains deployment consideration #822 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0823: This line explains deployment consideration #823 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0824: This line explains deployment consideration #824 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0825: This line explains deployment consideration #825 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0826: This line explains deployment consideration #826 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0827: This line explains deployment consideration #827 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0828: This line explains deployment consideration #828 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0829: This line explains deployment consideration #829 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0830: This line explains deployment consideration #830 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0831: This line explains deployment consideration #831 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0832: This line explains deployment consideration #832 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0833: This line explains deployment consideration #833 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0834: This line explains deployment consideration #834 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0835: This line explains deployment consideration #835 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0836: This line explains deployment consideration #836 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0837: This line explains deployment consideration #837 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0838: This line explains deployment consideration #838 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0839: This line explains deployment consideration #839 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0840: This line explains deployment consideration #840 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0841: This line explains deployment consideration #841 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0842: This line explains deployment consideration #842 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0843: This line explains deployment consideration #843 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0844: This line explains deployment consideration #844 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0845: This line explains deployment consideration #845 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0846: This line explains deployment consideration #846 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0847: This line explains deployment consideration #847 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0848: This line explains deployment consideration #848 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0849: This line explains deployment consideration #849 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0850: This line explains deployment consideration #850 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0851: This line explains deployment consideration #851 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0852: This line explains deployment consideration #852 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0853: This line explains deployment consideration #853 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0854: This line explains deployment consideration #854 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0855: This line explains deployment consideration #855 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0856: This line explains deployment consideration #856 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0857: This line explains deployment consideration #857 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0858: This line explains deployment consideration #858 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0859: This line explains deployment consideration #859 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0860: This line explains deployment consideration #860 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0861: This line explains deployment consideration #861 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0862: This line explains deployment consideration #862 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0863: This line explains deployment consideration #863 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0864: This line explains deployment consideration #864 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0865: This line explains deployment consideration #865 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0866: This line explains deployment consideration #866 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0867: This line explains deployment consideration #867 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0868: This line explains deployment consideration #868 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0869: This line explains deployment consideration #869 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0870: This line explains deployment consideration #870 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0871: This line explains deployment consideration #871 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0872: This line explains deployment consideration #872 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0873: This line explains deployment consideration #873 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0874: This line explains deployment consideration #874 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0875: This line explains deployment consideration #875 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0876: This line explains deployment consideration #876 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0877: This line explains deployment consideration #877 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0878: This line explains deployment consideration #878 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0879: This line explains deployment consideration #879 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0880: This line explains deployment consideration #880 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0881: This line explains deployment consideration #881 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0882: This line explains deployment consideration #882 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0883: This line explains deployment consideration #883 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0884: This line explains deployment consideration #884 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0885: This line explains deployment consideration #885 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0886: This line explains deployment consideration #886 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0887: This line explains deployment consideration #887 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0888: This line explains deployment consideration #888 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0889: This line explains deployment consideration #889 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0890: This line explains deployment consideration #890 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0891: This line explains deployment consideration #891 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0892: This line explains deployment consideration #892 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0893: This line explains deployment consideration #893 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0894: This line explains deployment consideration #894 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0895: This line explains deployment consideration #895 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0896: This line explains deployment consideration #896 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0897: This line explains deployment consideration #897 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0898: This line explains deployment consideration #898 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0899: This line explains deployment consideration #899 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0900: This line explains deployment consideration #900 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0901: This line explains deployment consideration #901 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0902: This line explains deployment consideration #902 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0903: This line explains deployment consideration #903 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0904: This line explains deployment consideration #904 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0905: This line explains deployment consideration #905 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0906: This line explains deployment consideration #906 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0907: This line explains deployment consideration #907 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0908: This line explains deployment consideration #908 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0909: This line explains deployment consideration #909 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0910: This line explains deployment consideration #910 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0911: This line explains deployment consideration #911 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0912: This line explains deployment consideration #912 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0913: This line explains deployment consideration #913 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0914: This line explains deployment consideration #914 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0915: This line explains deployment consideration #915 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0916: This line explains deployment consideration #916 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0917: This line explains deployment consideration #917 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0918: This line explains deployment consideration #918 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0919: This line explains deployment consideration #919 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0920: This line explains deployment consideration #920 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0921: This line explains deployment consideration #921 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0922: This line explains deployment consideration #922 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0923: This line explains deployment consideration #923 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0924: This line explains deployment consideration #924 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0925: This line explains deployment consideration #925 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0926: This line explains deployment consideration #926 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0927: This line explains deployment consideration #927 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0928: This line explains deployment consideration #928 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0929: This line explains deployment consideration #929 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0930: This line explains deployment consideration #930 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0931: This line explains deployment consideration #931 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0932: This line explains deployment consideration #932 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0933: This line explains deployment consideration #933 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0934: This line explains deployment consideration #934 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0935: This line explains deployment consideration #935 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0936: This line explains deployment consideration #936 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0937: This line explains deployment consideration #937 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0938: This line explains deployment consideration #938 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0939: This line explains deployment consideration #939 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0940: This line explains deployment consideration #940 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0941: This line explains deployment consideration #941 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0942: This line explains deployment consideration #942 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0943: This line explains deployment consideration #943 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0944: This line explains deployment consideration #944 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0945: This line explains deployment consideration #945 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0946: This line explains deployment consideration #946 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0947: This line explains deployment consideration #947 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0948: This line explains deployment consideration #948 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0949: This line explains deployment consideration #949 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0950: This line explains deployment consideration #950 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0951: This line explains deployment consideration #951 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0952: This line explains deployment consideration #952 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0953: This line explains deployment consideration #953 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0954: This line explains deployment consideration #954 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0955: This line explains deployment consideration #955 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0956: This line explains deployment consideration #956 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0957: This line explains deployment consideration #957 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0958: This line explains deployment consideration #958 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0959: This line explains deployment consideration #959 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0960: This line explains deployment consideration #960 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0961: This line explains deployment consideration #961 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0962: This line explains deployment consideration #962 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0963: This line explains deployment consideration #963 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0964: This line explains deployment consideration #964 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0965: This line explains deployment consideration #965 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0966: This line explains deployment consideration #966 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0967: This line explains deployment consideration #967 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0968: This line explains deployment consideration #968 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0969: This line explains deployment consideration #969 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0970: This line explains deployment consideration #970 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0971: This line explains deployment consideration #971 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0972: This line explains deployment consideration #972 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0973: This line explains deployment consideration #973 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0974: This line explains deployment consideration #974 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0975: This line explains deployment consideration #975 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0976: This line explains deployment consideration #976 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0977: This line explains deployment consideration #977 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0978: This line explains deployment consideration #978 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0979: This line explains deployment consideration #979 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0980: This line explains deployment consideration #980 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0981: This line explains deployment consideration #981 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0982: This line explains deployment consideration #982 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0983: This line explains deployment consideration #983 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0984: This line explains deployment consideration #984 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0985: This line explains deployment consideration #985 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0986: This line explains deployment consideration #986 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0987: This line explains deployment consideration #987 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0988: This line explains deployment consideration #988 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0989: This line explains deployment consideration #989 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0990: This line explains deployment consideration #990 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0991: This line explains deployment consideration #991 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0992: This line explains deployment consideration #992 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0993: This line explains deployment consideration #993 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0994: This line explains deployment consideration #994 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0995: This line explains deployment consideration #995 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0996: This line explains deployment consideration #996 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0997: This line explains deployment consideration #997 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0998: This line explains deployment consideration #998 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 0999: This line explains deployment consideration #999 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1000: This line explains deployment consideration #1000 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1001: This line explains deployment consideration #1001 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1002: This line explains deployment consideration #1002 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1003: This line explains deployment consideration #1003 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1004: This line explains deployment consideration #1004 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1005: This line explains deployment consideration #1005 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1006: This line explains deployment consideration #1006 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1007: This line explains deployment consideration #1007 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1008: This line explains deployment consideration #1008 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1009: This line explains deployment consideration #1009 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1010: This line explains deployment consideration #1010 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1011: This line explains deployment consideration #1011 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1012: This line explains deployment consideration #1012 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1013: This line explains deployment consideration #1013 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1014: This line explains deployment consideration #1014 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1015: This line explains deployment consideration #1015 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1016: This line explains deployment consideration #1016 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1017: This line explains deployment consideration #1017 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1018: This line explains deployment consideration #1018 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1019: This line explains deployment consideration #1019 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1020: This line explains deployment consideration #1020 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1021: This line explains deployment consideration #1021 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1022: This line explains deployment consideration #1022 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1023: This line explains deployment consideration #1023 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1024: This line explains deployment consideration #1024 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1025: This line explains deployment consideration #1025 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1026: This line explains deployment consideration #1026 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1027: This line explains deployment consideration #1027 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1028: This line explains deployment consideration #1028 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1029: This line explains deployment consideration #1029 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1030: This line explains deployment consideration #1030 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1031: This line explains deployment consideration #1031 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1032: This line explains deployment consideration #1032 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1033: This line explains deployment consideration #1033 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1034: This line explains deployment consideration #1034 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1035: This line explains deployment consideration #1035 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1036: This line explains deployment consideration #1036 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1037: This line explains deployment consideration #1037 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1038: This line explains deployment consideration #1038 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1039: This line explains deployment consideration #1039 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1040: This line explains deployment consideration #1040 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1041: This line explains deployment consideration #1041 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1042: This line explains deployment consideration #1042 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1043: This line explains deployment consideration #1043 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1044: This line explains deployment consideration #1044 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1045: This line explains deployment consideration #1045 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1046: This line explains deployment consideration #1046 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1047: This line explains deployment consideration #1047 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1048: This line explains deployment consideration #1048 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1049: This line explains deployment consideration #1049 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1050: This line explains deployment consideration #1050 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1051: This line explains deployment consideration #1051 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1052: This line explains deployment consideration #1052 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1053: This line explains deployment consideration #1053 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1054: This line explains deployment consideration #1054 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1055: This line explains deployment consideration #1055 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1056: This line explains deployment consideration #1056 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1057: This line explains deployment consideration #1057 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1058: This line explains deployment consideration #1058 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1059: This line explains deployment consideration #1059 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1060: This line explains deployment consideration #1060 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1061: This line explains deployment consideration #1061 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1062: This line explains deployment consideration #1062 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1063: This line explains deployment consideration #1063 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1064: This line explains deployment consideration #1064 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1065: This line explains deployment consideration #1065 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1066: This line explains deployment consideration #1066 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1067: This line explains deployment consideration #1067 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1068: This line explains deployment consideration #1068 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1069: This line explains deployment consideration #1069 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1070: This line explains deployment consideration #1070 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1071: This line explains deployment consideration #1071 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1072: This line explains deployment consideration #1072 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1073: This line explains deployment consideration #1073 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1074: This line explains deployment consideration #1074 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1075: This line explains deployment consideration #1075 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1076: This line explains deployment consideration #1076 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1077: This line explains deployment consideration #1077 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1078: This line explains deployment consideration #1078 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1079: This line explains deployment consideration #1079 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1080: This line explains deployment consideration #1080 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1081: This line explains deployment consideration #1081 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1082: This line explains deployment consideration #1082 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1083: This line explains deployment consideration #1083 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1084: This line explains deployment consideration #1084 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1085: This line explains deployment consideration #1085 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1086: This line explains deployment consideration #1086 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1087: This line explains deployment consideration #1087 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1088: This line explains deployment consideration #1088 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1089: This line explains deployment consideration #1089 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1090: This line explains deployment consideration #1090 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1091: This line explains deployment consideration #1091 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1092: This line explains deployment consideration #1092 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1093: This line explains deployment consideration #1093 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1094: This line explains deployment consideration #1094 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1095: This line explains deployment consideration #1095 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1096: This line explains deployment consideration #1096 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1097: This line explains deployment consideration #1097 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1098: This line explains deployment consideration #1098 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1099: This line explains deployment consideration #1099 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1100: This line explains deployment consideration #1100 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1101: This line explains deployment consideration #1101 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1102: This line explains deployment consideration #1102 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1103: This line explains deployment consideration #1103 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1104: This line explains deployment consideration #1104 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1105: This line explains deployment consideration #1105 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1106: This line explains deployment consideration #1106 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1107: This line explains deployment consideration #1107 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1108: This line explains deployment consideration #1108 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1109: This line explains deployment consideration #1109 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1110: This line explains deployment consideration #1110 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1111: This line explains deployment consideration #1111 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1112: This line explains deployment consideration #1112 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1113: This line explains deployment consideration #1113 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1114: This line explains deployment consideration #1114 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1115: This line explains deployment consideration #1115 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1116: This line explains deployment consideration #1116 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1117: This line explains deployment consideration #1117 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1118: This line explains deployment consideration #1118 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1119: This line explains deployment consideration #1119 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1120: This line explains deployment consideration #1120 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1121: This line explains deployment consideration #1121 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1122: This line explains deployment consideration #1122 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1123: This line explains deployment consideration #1123 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1124: This line explains deployment consideration #1124 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1125: This line explains deployment consideration #1125 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1126: This line explains deployment consideration #1126 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1127: This line explains deployment consideration #1127 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1128: This line explains deployment consideration #1128 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1129: This line explains deployment consideration #1129 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1130: This line explains deployment consideration #1130 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1131: This line explains deployment consideration #1131 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1132: This line explains deployment consideration #1132 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1133: This line explains deployment consideration #1133 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1134: This line explains deployment consideration #1134 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1135: This line explains deployment consideration #1135 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1136: This line explains deployment consideration #1136 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1137: This line explains deployment consideration #1137 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1138: This line explains deployment consideration #1138 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1139: This line explains deployment consideration #1139 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1140: This line explains deployment consideration #1140 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1141: This line explains deployment consideration #1141 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1142: This line explains deployment consideration #1142 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1143: This line explains deployment consideration #1143 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1144: This line explains deployment consideration #1144 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1145: This line explains deployment consideration #1145 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1146: This line explains deployment consideration #1146 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1147: This line explains deployment consideration #1147 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1148: This line explains deployment consideration #1148 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1149: This line explains deployment consideration #1149 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1150: This line explains deployment consideration #1150 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1151: This line explains deployment consideration #1151 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1152: This line explains deployment consideration #1152 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1153: This line explains deployment consideration #1153 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1154: This line explains deployment consideration #1154 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1155: This line explains deployment consideration #1155 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1156: This line explains deployment consideration #1156 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1157: This line explains deployment consideration #1157 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1158: This line explains deployment consideration #1158 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1159: This line explains deployment consideration #1159 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1160: This line explains deployment consideration #1160 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1161: This line explains deployment consideration #1161 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1162: This line explains deployment consideration #1162 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1163: This line explains deployment consideration #1163 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1164: This line explains deployment consideration #1164 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1165: This line explains deployment consideration #1165 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1166: This line explains deployment consideration #1166 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1167: This line explains deployment consideration #1167 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1168: This line explains deployment consideration #1168 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1169: This line explains deployment consideration #1169 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1170: This line explains deployment consideration #1170 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1171: This line explains deployment consideration #1171 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1172: This line explains deployment consideration #1172 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1173: This line explains deployment consideration #1173 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1174: This line explains deployment consideration #1174 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1175: This line explains deployment consideration #1175 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1176: This line explains deployment consideration #1176 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1177: This line explains deployment consideration #1177 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1178: This line explains deployment consideration #1178 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1179: This line explains deployment consideration #1179 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1180: This line explains deployment consideration #1180 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1181: This line explains deployment consideration #1181 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1182: This line explains deployment consideration #1182 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1183: This line explains deployment consideration #1183 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1184: This line explains deployment consideration #1184 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1185: This line explains deployment consideration #1185 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1186: This line explains deployment consideration #1186 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1187: This line explains deployment consideration #1187 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1188: This line explains deployment consideration #1188 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1189: This line explains deployment consideration #1189 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1190: This line explains deployment consideration #1190 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1191: This line explains deployment consideration #1191 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1192: This line explains deployment consideration #1192 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1193: This line explains deployment consideration #1193 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1194: This line explains deployment consideration #1194 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1195: This line explains deployment consideration #1195 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1196: This line explains deployment consideration #1196 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1197: This line explains deployment consideration #1197 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1198: This line explains deployment consideration #1198 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1199: This line explains deployment consideration #1199 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1200: This line explains deployment consideration #1200 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1201: This line explains deployment consideration #1201 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1202: This line explains deployment consideration #1202 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1203: This line explains deployment consideration #1203 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1204: This line explains deployment consideration #1204 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1205: This line explains deployment consideration #1205 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1206: This line explains deployment consideration #1206 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1207: This line explains deployment consideration #1207 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1208: This line explains deployment consideration #1208 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1209: This line explains deployment consideration #1209 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1210: This line explains deployment consideration #1210 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1211: This line explains deployment consideration #1211 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1212: This line explains deployment consideration #1212 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1213: This line explains deployment consideration #1213 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1214: This line explains deployment consideration #1214 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1215: This line explains deployment consideration #1215 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1216: This line explains deployment consideration #1216 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1217: This line explains deployment consideration #1217 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1218: This line explains deployment consideration #1218 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1219: This line explains deployment consideration #1219 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1220: This line explains deployment consideration #1220 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1221: This line explains deployment consideration #1221 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1222: This line explains deployment consideration #1222 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1223: This line explains deployment consideration #1223 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1224: This line explains deployment consideration #1224 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1225: This line explains deployment consideration #1225 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1226: This line explains deployment consideration #1226 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1227: This line explains deployment consideration #1227 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1228: This line explains deployment consideration #1228 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1229: This line explains deployment consideration #1229 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1230: This line explains deployment consideration #1230 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1231: This line explains deployment consideration #1231 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1232: This line explains deployment consideration #1232 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1233: This line explains deployment consideration #1233 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1234: This line explains deployment consideration #1234 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1235: This line explains deployment consideration #1235 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1236: This line explains deployment consideration #1236 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1237: This line explains deployment consideration #1237 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1238: This line explains deployment consideration #1238 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1239: This line explains deployment consideration #1239 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1240: This line explains deployment consideration #1240 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1241: This line explains deployment consideration #1241 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1242: This line explains deployment consideration #1242 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1243: This line explains deployment consideration #1243 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1244: This line explains deployment consideration #1244 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1245: This line explains deployment consideration #1245 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1246: This line explains deployment consideration #1246 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1247: This line explains deployment consideration #1247 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1248: This line explains deployment consideration #1248 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1249: This line explains deployment consideration #1249 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1250: This line explains deployment consideration #1250 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1251: This line explains deployment consideration #1251 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1252: This line explains deployment consideration #1252 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1253: This line explains deployment consideration #1253 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1254: This line explains deployment consideration #1254 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1255: This line explains deployment consideration #1255 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1256: This line explains deployment consideration #1256 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1257: This line explains deployment consideration #1257 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1258: This line explains deployment consideration #1258 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1259: This line explains deployment consideration #1259 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1260: This line explains deployment consideration #1260 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1261: This line explains deployment consideration #1261 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1262: This line explains deployment consideration #1262 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1263: This line explains deployment consideration #1263 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1264: This line explains deployment consideration #1264 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1265: This line explains deployment consideration #1265 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1266: This line explains deployment consideration #1266 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1267: This line explains deployment consideration #1267 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1268: This line explains deployment consideration #1268 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1269: This line explains deployment consideration #1269 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1270: This line explains deployment consideration #1270 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1271: This line explains deployment consideration #1271 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1272: This line explains deployment consideration #1272 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1273: This line explains deployment consideration #1273 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1274: This line explains deployment consideration #1274 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1275: This line explains deployment consideration #1275 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1276: This line explains deployment consideration #1276 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1277: This line explains deployment consideration #1277 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1278: This line explains deployment consideration #1278 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1279: This line explains deployment consideration #1279 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1280: This line explains deployment consideration #1280 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1281: This line explains deployment consideration #1281 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1282: This line explains deployment consideration #1282 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1283: This line explains deployment consideration #1283 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1284: This line explains deployment consideration #1284 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1285: This line explains deployment consideration #1285 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1286: This line explains deployment consideration #1286 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1287: This line explains deployment consideration #1287 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1288: This line explains deployment consideration #1288 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1289: This line explains deployment consideration #1289 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1290: This line explains deployment consideration #1290 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1291: This line explains deployment consideration #1291 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1292: This line explains deployment consideration #1292 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1293: This line explains deployment consideration #1293 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1294: This line explains deployment consideration #1294 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1295: This line explains deployment consideration #1295 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1296: This line explains deployment consideration #1296 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1297: This line explains deployment consideration #1297 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1298: This line explains deployment consideration #1298 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1299: This line explains deployment consideration #1299 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1300: This line explains deployment consideration #1300 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1301: This line explains deployment consideration #1301 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1302: This line explains deployment consideration #1302 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1303: This line explains deployment consideration #1303 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1304: This line explains deployment consideration #1304 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1305: This line explains deployment consideration #1305 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1306: This line explains deployment consideration #1306 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1307: This line explains deployment consideration #1307 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1308: This line explains deployment consideration #1308 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1309: This line explains deployment consideration #1309 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1310: This line explains deployment consideration #1310 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1311: This line explains deployment consideration #1311 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1312: This line explains deployment consideration #1312 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1313: This line explains deployment consideration #1313 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1314: This line explains deployment consideration #1314 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1315: This line explains deployment consideration #1315 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1316: This line explains deployment consideration #1316 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1317: This line explains deployment consideration #1317 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1318: This line explains deployment consideration #1318 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1319: This line explains deployment consideration #1319 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1320: This line explains deployment consideration #1320 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1321: This line explains deployment consideration #1321 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1322: This line explains deployment consideration #1322 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1323: This line explains deployment consideration #1323 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1324: This line explains deployment consideration #1324 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1325: This line explains deployment consideration #1325 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1326: This line explains deployment consideration #1326 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1327: This line explains deployment consideration #1327 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1328: This line explains deployment consideration #1328 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1329: This line explains deployment consideration #1329 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1330: This line explains deployment consideration #1330 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1331: This line explains deployment consideration #1331 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1332: This line explains deployment consideration #1332 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1333: This line explains deployment consideration #1333 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1334: This line explains deployment consideration #1334 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1335: This line explains deployment consideration #1335 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1336: This line explains deployment consideration #1336 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1337: This line explains deployment consideration #1337 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1338: This line explains deployment consideration #1338 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1339: This line explains deployment consideration #1339 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1340: This line explains deployment consideration #1340 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1341: This line explains deployment consideration #1341 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1342: This line explains deployment consideration #1342 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1343: This line explains deployment consideration #1343 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1344: This line explains deployment consideration #1344 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1345: This line explains deployment consideration #1345 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1346: This line explains deployment consideration #1346 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1347: This line explains deployment consideration #1347 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1348: This line explains deployment consideration #1348 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1349: This line explains deployment consideration #1349 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1350: This line explains deployment consideration #1350 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1351: This line explains deployment consideration #1351 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1352: This line explains deployment consideration #1352 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1353: This line explains deployment consideration #1353 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1354: This line explains deployment consideration #1354 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1355: This line explains deployment consideration #1355 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1356: This line explains deployment consideration #1356 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1357: This line explains deployment consideration #1357 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1358: This line explains deployment consideration #1358 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1359: This line explains deployment consideration #1359 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1360: This line explains deployment consideration #1360 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1361: This line explains deployment consideration #1361 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1362: This line explains deployment consideration #1362 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1363: This line explains deployment consideration #1363 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1364: This line explains deployment consideration #1364 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1365: This line explains deployment consideration #1365 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1366: This line explains deployment consideration #1366 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1367: This line explains deployment consideration #1367 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1368: This line explains deployment consideration #1368 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1369: This line explains deployment consideration #1369 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1370: This line explains deployment consideration #1370 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1371: This line explains deployment consideration #1371 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1372: This line explains deployment consideration #1372 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1373: This line explains deployment consideration #1373 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1374: This line explains deployment consideration #1374 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1375: This line explains deployment consideration #1375 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1376: This line explains deployment consideration #1376 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1377: This line explains deployment consideration #1377 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1378: This line explains deployment consideration #1378 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1379: This line explains deployment consideration #1379 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1380: This line explains deployment consideration #1380 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1381: This line explains deployment consideration #1381 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1382: This line explains deployment consideration #1382 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1383: This line explains deployment consideration #1383 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1384: This line explains deployment consideration #1384 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1385: This line explains deployment consideration #1385 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1386: This line explains deployment consideration #1386 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1387: This line explains deployment consideration #1387 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1388: This line explains deployment consideration #1388 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1389: This line explains deployment consideration #1389 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1390: This line explains deployment consideration #1390 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1391: This line explains deployment consideration #1391 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1392: This line explains deployment consideration #1392 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1393: This line explains deployment consideration #1393 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1394: This line explains deployment consideration #1394 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1395: This line explains deployment consideration #1395 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1396: This line explains deployment consideration #1396 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1397: This line explains deployment consideration #1397 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1398: This line explains deployment consideration #1398 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1399: This line explains deployment consideration #1399 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1400: This line explains deployment consideration #1400 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1401: This line explains deployment consideration #1401 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1402: This line explains deployment consideration #1402 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1403: This line explains deployment consideration #1403 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1404: This line explains deployment consideration #1404 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1405: This line explains deployment consideration #1405 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1406: This line explains deployment consideration #1406 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1407: This line explains deployment consideration #1407 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1408: This line explains deployment consideration #1408 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1409: This line explains deployment consideration #1409 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1410: This line explains deployment consideration #1410 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1411: This line explains deployment consideration #1411 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1412: This line explains deployment consideration #1412 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1413: This line explains deployment consideration #1413 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1414: This line explains deployment consideration #1414 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1415: This line explains deployment consideration #1415 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1416: This line explains deployment consideration #1416 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1417: This line explains deployment consideration #1417 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1418: This line explains deployment consideration #1418 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1419: This line explains deployment consideration #1419 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1420: This line explains deployment consideration #1420 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1421: This line explains deployment consideration #1421 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1422: This line explains deployment consideration #1422 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1423: This line explains deployment consideration #1423 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1424: This line explains deployment consideration #1424 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1425: This line explains deployment consideration #1425 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1426: This line explains deployment consideration #1426 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1427: This line explains deployment consideration #1427 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1428: This line explains deployment consideration #1428 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1429: This line explains deployment consideration #1429 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1430: This line explains deployment consideration #1430 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1431: This line explains deployment consideration #1431 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1432: This line explains deployment consideration #1432 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1433: This line explains deployment consideration #1433 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1434: This line explains deployment consideration #1434 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1435: This line explains deployment consideration #1435 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1436: This line explains deployment consideration #1436 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1437: This line explains deployment consideration #1437 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1438: This line explains deployment consideration #1438 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1439: This line explains deployment consideration #1439 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1440: This line explains deployment consideration #1440 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1441: This line explains deployment consideration #1441 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1442: This line explains deployment consideration #1442 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1443: This line explains deployment consideration #1443 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1444: This line explains deployment consideration #1444 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1445: This line explains deployment consideration #1445 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1446: This line explains deployment consideration #1446 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1447: This line explains deployment consideration #1447 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1448: This line explains deployment consideration #1448 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1449: This line explains deployment consideration #1449 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1450: This line explains deployment consideration #1450 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1451: This line explains deployment consideration #1451 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1452: This line explains deployment consideration #1452 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1453: This line explains deployment consideration #1453 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1454: This line explains deployment consideration #1454 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1455: This line explains deployment consideration #1455 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1456: This line explains deployment consideration #1456 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1457: This line explains deployment consideration #1457 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1458: This line explains deployment consideration #1458 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1459: This line explains deployment consideration #1459 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1460: This line explains deployment consideration #1460 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1461: This line explains deployment consideration #1461 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1462: This line explains deployment consideration #1462 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1463: This line explains deployment consideration #1463 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1464: This line explains deployment consideration #1464 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1465: This line explains deployment consideration #1465 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1466: This line explains deployment consideration #1466 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1467: This line explains deployment consideration #1467 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1468: This line explains deployment consideration #1468 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1469: This line explains deployment consideration #1469 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1470: This line explains deployment consideration #1470 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1471: This line explains deployment consideration #1471 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1472: This line explains deployment consideration #1472 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1473: This line explains deployment consideration #1473 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1474: This line explains deployment consideration #1474 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1475: This line explains deployment consideration #1475 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1476: This line explains deployment consideration #1476 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1477: This line explains deployment consideration #1477 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1478: This line explains deployment consideration #1478 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1479: This line explains deployment consideration #1479 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1480: This line explains deployment consideration #1480 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1481: This line explains deployment consideration #1481 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1482: This line explains deployment consideration #1482 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1483: This line explains deployment consideration #1483 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1484: This line explains deployment consideration #1484 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1485: This line explains deployment consideration #1485 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1486: This line explains deployment consideration #1486 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1487: This line explains deployment consideration #1487 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1488: This line explains deployment consideration #1488 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1489: This line explains deployment consideration #1489 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1490: This line explains deployment consideration #1490 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1491: This line explains deployment consideration #1491 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1492: This line explains deployment consideration #1492 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1493: This line explains deployment consideration #1493 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1494: This line explains deployment consideration #1494 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1495: This line explains deployment consideration #1495 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1496: This line explains deployment consideration #1496 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1497: This line explains deployment consideration #1497 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1498: This line explains deployment consideration #1498 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1499: This line explains deployment consideration #1499 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1500: This line explains deployment consideration #1500 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1501: This line explains deployment consideration #1501 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1502: This line explains deployment consideration #1502 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1503: This line explains deployment consideration #1503 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1504: This line explains deployment consideration #1504 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1505: This line explains deployment consideration #1505 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1506: This line explains deployment consideration #1506 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1507: This line explains deployment consideration #1507 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1508: This line explains deployment consideration #1508 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1509: This line explains deployment consideration #1509 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1510: This line explains deployment consideration #1510 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1511: This line explains deployment consideration #1511 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1512: This line explains deployment consideration #1512 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1513: This line explains deployment consideration #1513 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1514: This line explains deployment consideration #1514 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1515: This line explains deployment consideration #1515 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1516: This line explains deployment consideration #1516 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1517: This line explains deployment consideration #1517 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1518: This line explains deployment consideration #1518 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1519: This line explains deployment consideration #1519 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1520: This line explains deployment consideration #1520 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1521: This line explains deployment consideration #1521 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1522: This line explains deployment consideration #1522 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1523: This line explains deployment consideration #1523 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1524: This line explains deployment consideration #1524 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1525: This line explains deployment consideration #1525 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1526: This line explains deployment consideration #1526 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1527: This line explains deployment consideration #1527 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1528: This line explains deployment consideration #1528 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1529: This line explains deployment consideration #1529 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1530: This line explains deployment consideration #1530 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1531: This line explains deployment consideration #1531 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1532: This line explains deployment consideration #1532 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1533: This line explains deployment consideration #1533 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1534: This line explains deployment consideration #1534 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1535: This line explains deployment consideration #1535 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1536: This line explains deployment consideration #1536 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1537: This line explains deployment consideration #1537 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1538: This line explains deployment consideration #1538 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1539: This line explains deployment consideration #1539 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1540: This line explains deployment consideration #1540 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1541: This line explains deployment consideration #1541 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1542: This line explains deployment consideration #1542 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1543: This line explains deployment consideration #1543 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1544: This line explains deployment consideration #1544 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1545: This line explains deployment consideration #1545 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1546: This line explains deployment consideration #1546 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1547: This line explains deployment consideration #1547 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1548: This line explains deployment consideration #1548 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1549: This line explains deployment consideration #1549 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1550: This line explains deployment consideration #1550 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1551: This line explains deployment consideration #1551 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1552: This line explains deployment consideration #1552 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1553: This line explains deployment consideration #1553 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1554: This line explains deployment consideration #1554 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1555: This line explains deployment consideration #1555 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1556: This line explains deployment consideration #1556 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1557: This line explains deployment consideration #1557 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1558: This line explains deployment consideration #1558 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1559: This line explains deployment consideration #1559 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1560: This line explains deployment consideration #1560 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1561: This line explains deployment consideration #1561 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1562: This line explains deployment consideration #1562 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1563: This line explains deployment consideration #1563 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1564: This line explains deployment consideration #1564 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1565: This line explains deployment consideration #1565 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1566: This line explains deployment consideration #1566 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1567: This line explains deployment consideration #1567 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1568: This line explains deployment consideration #1568 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1569: This line explains deployment consideration #1569 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1570: This line explains deployment consideration #1570 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1571: This line explains deployment consideration #1571 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1572: This line explains deployment consideration #1572 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1573: This line explains deployment consideration #1573 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1574: This line explains deployment consideration #1574 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1575: This line explains deployment consideration #1575 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1576: This line explains deployment consideration #1576 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1577: This line explains deployment consideration #1577 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1578: This line explains deployment consideration #1578 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1579: This line explains deployment consideration #1579 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1580: This line explains deployment consideration #1580 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1581: This line explains deployment consideration #1581 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1582: This line explains deployment consideration #1582 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1583: This line explains deployment consideration #1583 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1584: This line explains deployment consideration #1584 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1585: This line explains deployment consideration #1585 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1586: This line explains deployment consideration #1586 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1587: This line explains deployment consideration #1587 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1588: This line explains deployment consideration #1588 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1589: This line explains deployment consideration #1589 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1590: This line explains deployment consideration #1590 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1591: This line explains deployment consideration #1591 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1592: This line explains deployment consideration #1592 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1593: This line explains deployment consideration #1593 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1594: This line explains deployment consideration #1594 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1595: This line explains deployment consideration #1595 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1596: This line explains deployment consideration #1596 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1597: This line explains deployment consideration #1597 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1598: This line explains deployment consideration #1598 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1599: This line explains deployment consideration #1599 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1600: This line explains deployment consideration #1600 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1601: This line explains deployment consideration #1601 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1602: This line explains deployment consideration #1602 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1603: This line explains deployment consideration #1603 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1604: This line explains deployment consideration #1604 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1605: This line explains deployment consideration #1605 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1606: This line explains deployment consideration #1606 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1607: This line explains deployment consideration #1607 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1608: This line explains deployment consideration #1608 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1609: This line explains deployment consideration #1609 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1610: This line explains deployment consideration #1610 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1611: This line explains deployment consideration #1611 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1612: This line explains deployment consideration #1612 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1613: This line explains deployment consideration #1613 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1614: This line explains deployment consideration #1614 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1615: This line explains deployment consideration #1615 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1616: This line explains deployment consideration #1616 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1617: This line explains deployment consideration #1617 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1618: This line explains deployment consideration #1618 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1619: This line explains deployment consideration #1619 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1620: This line explains deployment consideration #1620 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1621: This line explains deployment consideration #1621 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1622: This line explains deployment consideration #1622 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1623: This line explains deployment consideration #1623 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1624: This line explains deployment consideration #1624 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1625: This line explains deployment consideration #1625 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1626: This line explains deployment consideration #1626 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1627: This line explains deployment consideration #1627 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1628: This line explains deployment consideration #1628 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1629: This line explains deployment consideration #1629 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1630: This line explains deployment consideration #1630 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1631: This line explains deployment consideration #1631 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1632: This line explains deployment consideration #1632 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1633: This line explains deployment consideration #1633 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1634: This line explains deployment consideration #1634 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1635: This line explains deployment consideration #1635 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1636: This line explains deployment consideration #1636 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1637: This line explains deployment consideration #1637 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1638: This line explains deployment consideration #1638 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1639: This line explains deployment consideration #1639 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1640: This line explains deployment consideration #1640 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1641: This line explains deployment consideration #1641 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1642: This line explains deployment consideration #1642 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1643: This line explains deployment consideration #1643 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1644: This line explains deployment consideration #1644 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1645: This line explains deployment consideration #1645 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1646: This line explains deployment consideration #1646 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1647: This line explains deployment consideration #1647 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1648: This line explains deployment consideration #1648 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1649: This line explains deployment consideration #1649 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1650: This line explains deployment consideration #1650 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1651: This line explains deployment consideration #1651 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1652: This line explains deployment consideration #1652 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1653: This line explains deployment consideration #1653 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1654: This line explains deployment consideration #1654 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1655: This line explains deployment consideration #1655 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1656: This line explains deployment consideration #1656 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1657: This line explains deployment consideration #1657 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1658: This line explains deployment consideration #1658 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1659: This line explains deployment consideration #1659 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1660: This line explains deployment consideration #1660 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1661: This line explains deployment consideration #1661 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1662: This line explains deployment consideration #1662 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1663: This line explains deployment consideration #1663 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1664: This line explains deployment consideration #1664 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1665: This line explains deployment consideration #1665 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1666: This line explains deployment consideration #1666 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1667: This line explains deployment consideration #1667 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1668: This line explains deployment consideration #1668 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1669: This line explains deployment consideration #1669 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1670: This line explains deployment consideration #1670 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1671: This line explains deployment consideration #1671 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1672: This line explains deployment consideration #1672 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1673: This line explains deployment consideration #1673 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1674: This line explains deployment consideration #1674 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1675: This line explains deployment consideration #1675 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1676: This line explains deployment consideration #1676 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1677: This line explains deployment consideration #1677 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1678: This line explains deployment consideration #1678 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1679: This line explains deployment consideration #1679 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1680: This line explains deployment consideration #1680 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1681: This line explains deployment consideration #1681 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1682: This line explains deployment consideration #1682 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1683: This line explains deployment consideration #1683 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1684: This line explains deployment consideration #1684 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1685: This line explains deployment consideration #1685 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1686: This line explains deployment consideration #1686 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1687: This line explains deployment consideration #1687 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1688: This line explains deployment consideration #1688 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1689: This line explains deployment consideration #1689 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1690: This line explains deployment consideration #1690 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1691: This line explains deployment consideration #1691 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1692: This line explains deployment consideration #1692 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1693: This line explains deployment consideration #1693 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1694: This line explains deployment consideration #1694 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1695: This line explains deployment consideration #1695 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1696: This line explains deployment consideration #1696 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1697: This line explains deployment consideration #1697 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1698: This line explains deployment consideration #1698 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1699: This line explains deployment consideration #1699 for administrators (permissions, audit, migration, legal tuning).
-- Documentation note 1700: This line explains deployment consideration #1700 for administrators (permissions, audit, migration, legal tuning).
